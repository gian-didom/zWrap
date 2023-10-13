function packNGo(buildFolderOrBuildInfo, varargin)
%PACKNGO - package all files in a buildInfo object into a zip file
%
%   packNGo(buildFolderOrBuildInfo) packs all files into zip file named
%   <model>.zip with a flat hierarchy.  An error is issued if
%   there are any files in different folders with the same
%   filename.
%
%   packNGo(buildFolderOrBuildInfo,propVals) packs the files according to the
%   property/value pairs specified.  propVals must be a cell
%   array with a sequence of property-value pairs.
%   The property-value pairs may be provided in any order.
%
%   The valid properties and their default values are:
%   
%   property              default        description
%   'fileName'            'model.zip'    The files are packed into a zip file with
%                                        the name specified.  If no extension is
%                                        provided, '.zip' will automatically be added.
%
%   'packType'            'flat'         If 'flat', the files are packed in a zip file as a single, 
%                                        flat folder. A check is made for duplicate filenames coming
%                                        from separate folders and an error is produced if the
%                                        condition exists.
%                                        If 'hierarchical', the files are packaged hierarchically in 
%                                        a primary zip file.
%
%   'nestedZipFiles'      true           If true, the files are packed into a primary zip file that 
%                                        contains three secondary zip files:
%                                        1) mlrFiles.zip - Contains the files in your matlabroot folder tree
%                                        2) sDirFiles.zip - Contains the files in and under your build folder
%                                        3) otherFiles.zip - Required files not in the matlabroot or start 
%                                           folder trees
%                                        If false, the primary zip file contains folders.
%
%   'minimalHeaders'      true           If true, include only the minimal header files required 
%                                        to build the code in the zip file.
%                                        If false, include header files found on the include path in the zip file.
%
%   'includeReport'       false          If true, include the html folder in the zip file.
%                                        If false, do not include the html folder in the zip file.
%
%   'ignoreParseError'    false          If true, do not terminate on parse errors.
%                                        If false, error out on parse errors.
%
%   'ignoreFileMissing'   false          If true, do not terminate on missing files errors.
%                                        If false, terminate on missing file errors.

% Copyright 2006-2023 The MathWorks, Inc.
    
    narginchk(1, inf);
    
    if nargin==2 && iscell(varargin{1})
        % for backwards compatibility, check for the old way of passing in
        % args, which is a single arg - a cell array of prop-val pairs.
        varargin = varargin{1};
    end
    
    buildFolderOrBuildInfo = convertStringsToChars(buildFolderOrBuildInfo);
    [varargin{:}] = convertStringsToChars(varargin{:});
    
    p = inputParser;
    p.StructExpand  = true;
    p.CaseSensitive = false; 
    
    p.addParameter('packType',              'flat',              @(x)any(strcmp(x,{'flat','hierarchical'})));
    p.addParameter('fileName',                  '',              @ischar);
    p.addParameter('minimalHeaders',          true,              @islogical);
    p.addParameter('nestedZipFiles',          true,              @islogical);
    p.addParameter('includeReport',          false,              @islogical);
    p.addParameter('ignoreParseError',       false,              @islogical);
    p.addParameter('ignoreFileMissing',      false,              @islogical);
    
    p.parse(varargin{:});

    % verify the args and get them in a convenient format
    [args, buildInfo] = locCheckArgs(buildFolderOrBuildInfo, p.Results);
    
    % If packNGo was called with a buildInfo.mat or a buildFolder,
    % use it to determine the build folder
    if ~isempty(args.buildInfoMatFile)
        % If packNGo was called with a buildInfo.mat or a buildFolder,
        % use it to determine the build folder and the location of
        % compileInfo.mat
        buildDir = fileparts(args.buildInfoMatFile);
    else
        bDirs = buildInfo.getSourcePaths(true,{'BuildDir'});
        if isempty(bDirs)
            buildDir = pwd;
        else
            buildDir = bDirs{1};            
        end
    end

    % if packNGo is disabled, just return
    if buildInfo.Settings.DisablePackNGo
        MSLDiagnostic('RTW:buildInfo:packNGoDisabled').reportAsWarning;
        return;
    end
    
    % make sure the paths and extensions are all filled in.
    buildInfo.updateFilePathsAndExtensions();

    % search for all the header files.
    buildInfo.findIncludeFiles('minimalHeaders',args.minimalHeaders,...
                               'ignoreParseError',args.ignoreParseError);
    
    
    switch args.packType
      case 'flat'
        locPackFlat(buildInfo,args,buildDir);
      case 'hierarchical'
        locPackHierarchical(buildInfo,args,buildDir);
    end
end

%------------------------------------------------------------------------------
%
% function: locPackFlat 
%
% inputs:
%    h
%    args
%    buildDir
%
% returns:
%    
%
% abstract:
%
%
%------------------------------------------------------------------------------
function locPackFlat(buildInfo, args, buildDir)

    % for flat packing, do not pack ModelRef and SharedUtils buildInfo.mat's to
    % avoid eventual filename conflicts with the top model buildInfo.mat
    packBuildInfos = false;
    % get all of the files
    [fPathNames, names] = locGetAllFiles(buildInfo, args, buildDir, packBuildInfos);


    if args.includeReport
        % flat packing does not support including the html report because
        % there will always be duplicate file names which zip will
        % throw an error on.
        MSLDiagnostic('RTW:buildInfo:NoHTMLInFlatPack').reportAsWarning;
    end
    % check for duplicate file
    buildInfo.checkForDups(fPathNames,names);
    
    % serialize buildInfo in a temporary location and add it to the list
    % of files to zip
    tempDir = tempname;
    locMkDirWithWarningCheck(tempDir);
    cleanupBiDir = onCleanup(@() rmdir(tempDir, 's'));
    biFile = fullfile(tempDir, 'buildInfo.mat');
    locSaveBuildInfoMat(args.buildInfoMatFile, biFile, buildInfo);
    
    allFiles = [fPathNames biFile];

    if args.ignoreFileMissing
        [allFiles, missingFiles] = locCheckFileExist(allFiles);
        if ~isempty(missingFiles)
            MSLDiagnostic('RTW:buildInfo:FilesMissing',sprintf('%s\n',missingFiles{:})).reportAsWarning;
        end
    end
    
    
    % zip the files up
    zip(args.fileName,cellfun(@(x) strrep(x, '\', '/'), allFiles, 'UniformOutput', false));

end
%End of function

%------------------------------------------------------------------------------
%
% function: locPackHierarchical 
%
% inputs:
%    buildInfo
%    args
%    buildDir
%
% returns:
%    
%
% abstract:
%
%
%------------------------------------------------------------------------------
function locPackHierarchical(buildInfo, args, buildDir)

    % for hierarchical packing, pack the entire hierarchy of buildInfo's (including 
    % the ModelRef and SharedUtils buildInfo's) to allow recompiling after the relocation
    packBuildInfos = true;
    % get all of the files
    [fPathNames, names] = locGetAllFiles(buildInfo, args, buildDir, packBuildInfos);

    % add the html folders if they exist.
    if args.includeReport
        [fPathNames, args.addedDirs] = locGetHTMLFolders(buildInfo,fPathNames);
        % the names vector needs to be the same length as the fPathNames.  since
        % the addedDirs are dirs, there is no name to set.  Additionally,
        % the HTML dirs are guaranteed to be under the startdir, so they
        % will get filtered out before the dup check
        tmp(1:length(args.addedDirs)) = {''};
        names = [names tmp];
    else
        args.addedDirs = {};
    end

    locGenerateManifest(buildInfo,fPathNames, buildDir);
    sDir = buildInfo.Settings.LocalAnchorDir;
    if isempty(sDir)
        sDir = coder.make.internal.getStartDirForPackNGo(buildInfo);
    end
    if args.ignoreFileMissing
        [fPathNames, missingFiles] = locCheckFileExist(fPathNames);
        if ~isempty(missingFiles)
            MSLDiagnostic('RTW:buildInfo:FilesMissing',sprintf('%s\n',missingFiles{:})).reportAsWarning;
        end
    end

    [sDirFiles, mlrFiles, fPathNames, ~, pathToMainBuildInfo] = getHierarchicalFileList(buildInfo, fPathNames, names);
    
    if (args.nestedZipFiles == true)
        locCreateNestedZip(buildInfo, args, sDir, mlrFiles, sDirFiles, fPathNames, pathToMainBuildInfo);
    else
        locCreateFullPathZip(buildInfo, args, sDir, mlrFiles, sDirFiles, fPathNames, pathToMainBuildInfo);
    end
    
end    
%End of function

%------------------------------------------------------------------------------
%
% function: locCreateNestedZip
%
%
%------------------------------------------------------------------------------
function locCreateNestedZip(buildInfo, args, sDir, mlrFiles, sDirFiles, otherFiles, pathToMainBuildInfo)
    
    [mlrParent, mlRootDir] = coder.make.internal.getDirPathAndNameForPackNGo(buildInfo.Settings.Matlabroot);

    % When this gets unzipped, it will be put in a subdir that is the
    % same as the matlab installation dir name (just the final folder
    % name).
    mlrFiles = fullfile(mlRootDir, mlrFiles);

    tdir = tempname;
    locMkDirWithWarningCheck(tdir);
    
    try
        zipFiles = {};
        %zip em 
        if ~isempty(mlrFiles)
            zFile = fullfile(tdir,'mlrFiles.zip'); 
            zip(zFile,mlrFiles,mlrParent);
            zipFiles = {zFile};
        end
        
        savePWD = pwd;
        cd(tdir);
        sDirFolder  = locCopyFiles(args.addedDirs, sDir, sDirFiles, true);
        copiedStartDir = fullfile(tdir, sDirFolder);
        
        % Serialize buildInfo inside the copied StartDir
        biFile = fullfile(copiedStartDir, pathToMainBuildInfo);
        locSaveBuildInfoMat(args.buildInfoMatFile, biFile, buildInfo);
        sDirFiles = [sDirFiles pathToMainBuildInfo];

        zFile = fullfile(tdir,'sDirFiles.zip');
        zip(zFile, sDirFiles, copiedStartDir);
        zipFiles = [zipFiles zFile];
        cd(savePWD);
        
        if ~isempty(otherFiles)
            zFile = fullfile(tdir,'otherFiles.zip');
            zip(zFile ,otherFiles);
            zipFiles = [zipFiles zFile];
        end
        
        zip(args.fileName,zipFiles);
    catch exc
        coder.make.internal.removeDir(tdir);
        rethrow (exc);
    end
    coder.make.internal.removeDir(tdir);
    
end    
%End of function

%------------------------------------------------------------------------------
%
% function: locCreateFullPathZip
%
%
%------------------------------------------------------------------------------
function locCreateFullPathZip(buildInfo, args, sDir, mlrFiles, sDirFiles, otherFiles, pathToMainBuildInfo)
    
    tdir = tempname;
    locMkDirWithWarningCheck(tdir);

    savePWD = pwd;
    cd(tdir);
    
    try
        mlrFolder   = locCopyFiles(args.addedDirs, buildInfo.Settings.Matlabroot, mlrFiles, true);
        sDirFolder  = locCopyFiles(args.addedDirs, sDir, sDirFiles, true);
        otherFolder = locCopyFiles(args.addedDirs, '', otherFiles, false, 'otherFiles');
        
        % Serialize buildInfo inside the copied StartDir
        biFile = fullfile(sDirFolder, pathToMainBuildInfo);
        locMkDirWithWarningCheck(fileparts(biFile));
        locSaveBuildInfoMat(args.buildInfoMatFile, biFile, buildInfo);

        zipFiles = {mlrFolder sDirFolder otherFolder};
        
        idx = ~cellfun(@isempty,zipFiles);
        zipFiles = zipFiles(idx);
        zip(args.fileName,zipFiles);
    catch exc
        cd(savePWD);
        coder.make.internal.removeDir(tdir)
        rethrow(exc);
    end
    cd(savePWD);
    coder.make.internal.removeDir(tdir);
end    
%End of function

function locSaveBuildInfoMat(buildInfoMatFile, biFile, buildInfo)
    if ~isempty(buildInfoMatFile)
        copyfile(buildInfoMatFile, biFile);
    end
    m = matfile(biFile, 'Writable', true);
    m.buildInfo = buildInfo;
end

%------------------------------------------------------------------------------
%
% function: locCopyFiles
%
%
%------------------------------------------------------------------------------
function rdName = locCopyFiles(addedDirs, rootDir, files,keepRelPaths, varargin)

    rdName = '';
    if isempty(files)
        return;
    end
    
    if keepRelPaths
        % name the root dir in the zip file the same as the final folder of the
        % rootDir from the source folder.
        [~, rdName] = coder.make.internal.getDirPathAndNameForPackNGo(rootDir);
    else
        rdName = varargin{1};
    end

    numCopyPairs = length(files);
    
    % construct pairs of source and destination files, and get the folder for 
    % each destination file 
    srcDestPairs(1:numCopyPairs) = {''};
    destPaths(1:numCopyPairs) = {''};
    
    % fullfile() will replace whatever the filesep is with the host filesep.  So
    % addedDirs needs to be "normalized" for the comparison below
    normAddedDirs = fullfile(addedDirs);
    for i=1:length(files)
        srcName = fullfile(rootDir,files{i});   
        isAddedDir = any(strcmp(srcName,normAddedDirs));
        % Directories might be confused for files for example when supplied with
        % no trailing filesep (See g2043475)
        % addNonBuildFiles(buildInfo, /path/dirname);
        if isfolder(srcName) && ~isAddedDir
            % Error out to avoid eventual undefined behaviors when copying or long delays 
            % when copying a voluminous directory
            error(message('coder_compile:CoderCompile:FileNameIsDirectory', srcName))
        end
        
        [fpath,fname,fext] = fileparts(files{i});        

        if keepRelPaths
            dstName = fullfile(pwd,rdName,files{i});
            % note: we only want the relative path here
            destPaths{i} = fullfile(rdName,fpath);
        else
            if ~isAddedDir
                dstName = fullfile(pwd,rdName,[fname fext]);
                destPaths{i} = rdName;
            end
        end
        srcDestPairs{i}  = {srcName, dstName};
    end
      
    % create the dirs before copying the files to prevent errors
    destPaths = unique(destPaths);
    for i=1:length(destPaths)
        fullpath = fullfile(pwd,destPaths{i});
        locMkDirWithWarningCheck(fullpath);
    end
    
    for i=1:length(srcDestPairs)
        % specifying the return arguments to copyfile prevents it from throwing
        % a warning in case of failure
        % TODO: this should be removed after g2062666
        [~,~,~] = copyfile(srcDestPairs{i}{1}, srcDestPairs{i}{2});
    end
    
end
%End of function

%=============================================================================
% Function: locMkDirWithWarningCheck 
%
% inputs:
%    relativeDirName
%
%
%
%=============================================================================
function locMkDirWithWarningCheck(relativeDirName)

    [status,msg,msgID] = builtin('mkdir',relativeDirName);
    
    % if the msgID is empty, then the dir was created.  However, if the
    % msg ID is non empty, it needs to be checked.  In some instances
    % during parallel directory creation, there is a race condition
    % between the 2 workers with respect to the file system.  the net
    % result is the call to mkdir reports a warning that the directory
    % already exists.  this warning is benign so can safely be
    % ignored.
    if ~isempty(msgID)
        
        % the logic below breaks down to:
        %   if the msgID is not the 'benign' warning,
        %        OR
        %      status is 0 (for any reason) 
        %   then 
        %      throw
        if ~(strcmp(msgID,'MATLAB:MKDIR:DirectoryExists') && (status == 1))
            exc = MException(msgID, msg);
            throw(exc);
        end
    end
    return;
end %End of Function locMkDirWithWarningCheck


%=============================================================================
% Function: locGetHTMLFolders 
%
% inputs:
%    buildInfo
%    fPathNames
%
%
%
%=============================================================================
function [fPathNames, addedDirs] = locGetHTMLFolders(buildInfo,fPathNames)

    buildDirs = buildInfo.getBuildDirList();
    
    BIPLibDirs = {};
    % Check shared utilities and any buildInPlace library folders for an
    % HTML sub-folder
    for i=1:length(buildInfo.LinkObj)
        if (buildInfo.LinkObj(i).BuildInPlace == true) || ...
                strcmp(buildInfo.LinkObj(i).Group, 'SHARED_SRC_LIB')
            BIPLibDirs{end+1} = buildInfo.LinkObj(i).Path; %#ok<AGROW>
        end
    end

    BIPLibDirs = RTW.unique(BIPLibDirs);
    
    buildDirs = [buildDirs buildInfo.formatPaths(BIPLibDirs)];
    
    htmlDirs(1:length(buildDirs)) = {''};
    
    mdlRefLibAdded = false;
    htmllibIdx = -1;
    
    for i=1:length(buildDirs)
        % Check if the build dirs contain report
        tmp = fullfile(buildDirs{i}, 'html');
        if isfolder(tmp)
            if ~rtw.report.ReportInfo.featureReportV2 || isfolder(fullfile(tmp, 'lib'))
                % Original PackNGo behavior
                htmlDirs{i} = strrep(tmp,filesep,buildInfo.Settings.FileSep);
            elseif ~isfolder(fullfile(tmp, 'lib'))
                % Check for the _htmllib in V2 model ref build
                tmpRefParent = fileparts(buildDirs{i});
                tmpRef = fullfile(tmpRefParent, '_htmllib');
                if ~mdlRefLibAdded && isfolder(tmpRef)
                    % Add the _htmllib folder for the first time
                    htmllibIdx = i;
                    mdlRefLibAdded = true;
                end
                
                % Still package rest of the model ref dirs
                htmlDirs{i} = strrep(tmp,filesep,buildInfo.Settings.FileSep);
            end
        end
    end
    
    idx = ~cellfun(@isempty,htmlDirs);
    
    % Add the _htmllib folder to it
    if htmllibIdx > 0
        tmpRefParent = fileparts(buildDirs{htmllibIdx});
        tmpRef = fullfile(tmpRefParent, '_htmllib');
        if isfolder(tmpRef)
            htmlLibFolder = strrep(tmpRef,filesep,buildInfo.Settings.FileSep);
        else
            htmlLibFolder = [];
        end
    else
        htmlLibFolder = [];
    end
    
    if isempty(htmlLibFolder)
        fPathNames = [fPathNames htmlDirs{idx}];
        addedDirs = htmlDirs(idx);
    else
        fPathNames = [fPathNames htmlDirs{idx} htmlLibFolder];
        addedDirs = [htmlDirs(idx) htmlLibFolder];
    end
    
end
%End of Function locGetHTMLFolders

%=============================================================================
% Function: locGenerateManifest
%
% inputs:
%    buildInfo
%    fPathNames
%    buildDir
%
%
%=============================================================================
function fPathNames = locGenerateManifest(buildInfo,fPathNames,buildDir)
    
    savePWD = pwd;
    cd(buildDir);
    mfname = [buildInfo.ModelName '_manifest.txt'];
    
    fid = fopen(mfname,'w');
    if (fid == -1)
        cd(savePWD);
        error(message('coder_compile:CoderCompile:fileOpenError', mfname))
    else
        txt = string(message('coder_compile:CoderCompile:ManifestText',buildInfo.ModelName));
        fwrite(fid,txt,'char');
        fPathNames = [fPathNames fullfile(pwd,mfname)];
        filelist = sprintf('%s\n',fPathNames{:});
        fwrite(fid,filelist,'char');
        buildInfo.addNonBuildFiles(mfname,pwd,'Manifest');
        fclose(fid);
    end
    
    cd(savePWD);
    
end


%------------------------------------------------------------------------------
%
% function: locCheckArgs 
%
% inputs:
%    buildFolderOrBuildInfo
%    varargin
%
%
% abstract:
%
%
%------------------------------------------------------------------------------
function [args, buildInfo] = locCheckArgs(buildFolderOrBuildInfo, args)

    if ischar(buildFolderOrBuildInfo)
        buildInfoMatFile = buildFolderOrBuildInfo;
        if ~isfile(buildInfoMatFile)
            buildInfoMatFile = fullfile(buildInfoMatFile, 'buildInfo.mat');
        end
        [~,~, ext] = fileparts(buildInfoMatFile);
        if coder.make.internal.isRelativePath(buildInfoMatFile)
            buildInfoMatFile = fullfile(pwd, buildInfoMatFile);
        end
        if ~isfile(buildInfoMatFile) || ~strcmp(ext, '.mat')
            error(message('coder_compile:CoderCompile:BuildInfoMissing', buildInfoMatFile));
        end
        bi = load(buildInfoMatFile, 'buildInfo');
        buildInfo = bi.buildInfo;
        % Update the StartDir in case the build was relocated
        % See g2348576
        postLoadUpdate(buildInfo, fileparts(buildInfoMatFile));
    else
        mustBeA(buildFolderOrBuildInfo, 'RTW.BuildInfo');
        buildInfoMatFile = '';
        buildInfo = buildFolderOrBuildInfo;
    end

    if isempty(args.fileName)
        args.fileName = buildInfo.ModelName;	
    end

    if coder.make.internal.isRelativePath(args.fileName)
        sDir = coder.make.internal.getStartDirForPackNGo(buildInfo);
        if isempty(sDir)
            sDir = pwd;
        end
        args.fileName = fullfile(sDir, args.fileName);
    end

    % if the report inclusion is disabled, override whatever the setting was.
    if buildInfo.Settings.DisableReportInPackNGo
        args.includeReport = false;
    end
    
    args.buildInfoMatFile = buildInfoMatFile;
end
%End of function

function [fPathNames, names] = locGetAllFiles(buildInfo, args, buildDir, packBuildInfos)
    
    % CMakeLists.txt files are packed only if the value of BuildMethod field in
    % compileInfo.mat is a CMake-based BuildMethod
    packCMakeLists = false;
    if strcmp(args.packType, 'hierarchical')
        lCompileInfo = coder.make.internal.CompileInfoFile(buildDir);
        lBuildMethod = getStoredBuildMethod(lCompileInfo);
        packCMakeLists = coder.make.internal.buildMethodIsCMake(lBuildMethod);
    end

    % First, get all files from BuildInfo
    [fPathNames, names] = getFullFileList(buildInfo, '', ...
        'GetBuildInfos', packBuildInfos, ...
        'GetCMakeLists', packCMakeLists);
    
    % Add the top-level CMakeLists.txt. Child files are included by getFullFileList
    if packCMakeLists
        topCMakeListsFile = fullfile(buildDir, 'CMakeLists.txt');
        fPathNames = [fPathNames topCMakeListsFile];
        names      = [names 'CMakeLists.txt'];
    end
       
    % Filter out the AUTOSAR RTE files in the stub sub-folder - we don't want to zip
    % those. The RTE files are in the buildInfo group '', i.e. not specified,
    % but this group could contain other non-RTE files. Here we examine all the
    % files in this group and find only the RTE files.
    filesInSfcnGroup  = buildInfo.getFiles('all',  true, true, {''});
    stubFolder = [buildDir buildInfo.Settings.FileSep 'stub'];
    stubFiles = filesInSfcnGroup(strncmp(stubFolder, filesInSfcnGroup, length(stubFolder)));
    [fPathNames, idx] = setdiff(fPathNames, stubFiles, 'stable');
    names = names(idx);
    
    % also filter out the static AUTOSAR RTE files
    rteFolder = fullfile(matlabroot, 'toolbox', 'coder', 'autosar', 'rte');
    rteFiles = filesInSfcnGroup(strncmp(rteFolder, filesInSfcnGroup, length(rteFolder)));
    [fPathNames, idx] = setdiff(fPathNames, rteFiles, 'stable');
    names = names(idx);
    
    % get any binary files that were built
    
    
    [fPathNames, names] = locGetBinaryFiles(buildInfo, buildDir, fPathNames, names);
    
    
end
%End of Function locGetAllFiles

%=============================================================================
function [existFiles, missingFiles] = locCheckFileExist(files)

    idx(1:length(files)) = true;
    for k = 1:length(files)
        dirContents = dir(files{k});
        if isempty(dirContents)
            %this file does not exist;
            idx(k) = false;  
        end
    end
    missingFiles = files(~idx);
    existFiles = files(idx);
    
end %End of Function locCheckFileExist

function newestSrcDate = locGetNewestSrcTimestamp(buildInfo)
% check the base source files for the newest timestamp
    srcs = buildInfo.getSourceFiles(true,true);
    newestSrcDate = 0;
    for i=1:length(srcs)
        dInfo = dir(srcs{i});
        if isempty(dInfo)
            continue;
        end
        if (dInfo.datenum > newestSrcDate)
            newestSrcDate = dInfo.datenum;
        end
    end
end

%=============================================================================
function  [fPathNames, names] = locGetBinaryFiles(buildInfo, buildDir, fPathNames, names)
    
    bFullNames = {};
    bNames = {};
    
    % Construct BuildTools object needed by getBuildFinalTarget
    [~, lToolchainName] = findBuildArg(buildInfo, 'DEFAULT_TOOLCHAIN_FOR_PACKNGO');
    if ~isempty(lToolchainName)
        lToolchainInfo = coder.make.internal.getToolchainInfoFromRegistry...
            (lToolchainName);
    else
        lToolchainInfo = [];
    end
    
    [~, lBuildVariant] = findBuildArg(buildInfo, 'DEFAULT_BUILD_VARIANT_FOR_PACKNGO');
    if ~isempty(lBuildVariant)
        lBuildVariant = coder.make.enum.BuildVariant(lBuildVariant);
        if lBuildVariant==coder.make.enum.BuildVariant.MEX_FILE
            % Do not pack any binaries for mex file build variant, g2189653/g2179199
            return
        end
    else
        % Cannot determine filename of final target without build variant
        return;
    end
    
    % MATLAB Coder can specify the name of the binary in a BuildArg
    % See g2026603
    [~, targetBaseName] = findBuildArg(buildInfo, 'MLC_TARGET_NAME');
    if isempty(targetBaseName)
        targetBaseName = buildInfo.ModelName;
    end
    
    finalTargetName = coder.make.internal.getFinalTargetName...
        (lBuildVariant, targetBaseName);
    
    [finalTarget, outputDir, auxiliaryTargets]  = coder.make.internal.getBuildFinalTarget...
        (buildInfo, lToolchainInfo, lBuildVariant, finalTargetName, ...
                    buildInfo.TargetLibSuffix);
    binaryTargets = [finalTarget auxiliaryTargets];

    if isempty(binaryTargets)
        % No build information in BuildInfo
        % For example, when manually populating a RTW.BuildInfo with
        % files/paths and calling packNGo
        return;
    end
    
    [~, lRelativePathToAnchor] = buildInfo.findBuildArg('RELATIVE_PATH_TO_ANCHOR');
    
    binaryTargetsPath = fullfile(buildDir, outputDir);
    binaryTargetsPath = strrep(binaryTargetsPath, '$(RELATIVE_PATH_TO_ANCHOR)', lRelativePathToAnchor);
    binaryTargetsPath = strrep(binaryTargetsPath, '$(START_DIR)', buildInfo.Settings.LocalAnchorDir);
    binaryTargetsPath = RTW.reduceRelativePath(binaryTargetsPath);
    binaryTargets = fullfile(binaryTargetsPath, binaryTargets);

    % Only binaries that are newer than the source files should be included.
    newestSrcDate = locGetNewestSrcTimestamp(buildInfo);

    for idx =1:numel(binaryTargets)
        currBinaryTarget = binaryTargets{idx};
        % First of all, check if the candidate binary target is a file.
        % If it is a folder, then dir(currBinaryTarget) would give us
        % the contents of the folder - but in that case, we know that
        % the identifier doesn't correspond to the compiled binary
        % target so we don't need to add it to the list of files to
        % pack.  isfile will return false if the filesystem identifier in
        % currBinaryTarget does not exist, or if it is a folder.
        if isfile(currBinaryTarget)
            dInfo = dir(currBinaryTarget);  
            if dInfo.datenum >= newestSrcDate  % We dInfo is scalar at this point because isfile returned true
                bFullNames = [bFullNames binaryTargets(idx)]; %#ok
                [~, binaryName, binaryExt] = fileparts(binaryTargets{idx});
                bNames = [bNames [binaryName binaryExt]]; %#ok
            end
        end
    end

    % The binaries may have been put in manually, if so simply remove them from
    % the new list.
    idx = ismember(bNames,names);
    bNames(idx) = [];
    bFullNames(idx) = [];
    
    names      = [names bNames];
    fPathNames = [fPathNames bFullNames];
end
