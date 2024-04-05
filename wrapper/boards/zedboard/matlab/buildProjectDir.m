function buildProjectDir(fcnName, targetFolderName, packDir, iss, oss, compileInfoStruct)
global zEnv zSettings

% 2. Add the "zed" folder to the project folder
copyfile(fullfile("boards", "zedboard", "bsp", "zed", "*"), ...
    fullfile(targetFolderName, "project", "zed"));

% 4. Add the {{fcnName}}_core1 folder (MATLAB function)
copyfile(fullfile("boards", "zedboard", "bsp", "app_core0", "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_core0", fcnName)));

% 4. Add the {{fcnName}}_core1 folder (MATLAB function)
copyfile(fullfile("boards", "zedboard", "bsp", "app_core1", "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_core1", fcnName)));

% 5. Add the {{fcnName}}_multicore_system folder
copyfile(fullfile("boards", "zedboard", "bsp", "app_multicore_system", "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_multicore_system", fcnName)));

% 6. Move the contents of the "pack" directory in the {{fncName}}_core1/src folder
copyfile(fullfile(packDir, "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_core1", fcnName), "src"));
% 6b. Replace the built-in function with the custom BSP functions
filesToReplace = dir(fullfile("boards", "zedboard", "replace"));
for j=1:numel(filesToReplace)
    filePath = fullfile("boards", "zedboard", "replace", filesToReplace(j).name);
    if not(isfile(filePath))
        continue;
    end
    [~, fileName, fileExt] = fileparts(filePath);
    if any(strcmp(fileExt, {'.c', '.h', '.cpp', '.hpp'}))

        fullfileName = strcat(fileName, fileExt);

        % The file to pick
        origFile = fullfile("boards", ...
                            "zedboard", ...
                            "replace", ...
                            fullfileName);

        % The location to parse the file into
        targetFile = fullfile(targetFolderName, ...
            "project", ...
            sprintf("%s_multicore_system", fcnName), ...
            fullfileName);

        % If exists, 
        if isfile(targetFile)
            % Force replace
            copyfile(origFile, targetFile, 'f');
        end

    end
end

copyfile(fullfile("boards", "zedboard", "replace"), ...
     fullfile(targetFolderName, "project", sprintf("%s_core1", fcnName), "src"));

% 7. Move the memory mapping file to the proper directory
copyfile(fullfile(targetFolderName, "generated", "memorymap.h"), ...
        fullfile(targetFolderName, ...
            "project", ...
            sprintf("%s_multicore_system", fcnName), ...
            'include_common'));

% 7. Move the Cpp calling function to the proper directory
copyfile(fullfile(targetFolderName, "generated", "callFunction.c"), ...
        fullfile(targetFolderName, ...
            "project", ...
            sprintf("%s_core1", fcnName), ...
            'src'));

copyfile(fullfile(targetFolderName, "generated", "callFunction.h"), ...
        fullfile(targetFolderName, ...
            "project", ...
            sprintf("%s_core1", fcnName), ...
            'src'));


% Create the fname.mk file in the folder

defines = [];
for i=1:(length(compileInfoStruct.Defines)-2)
    defines = [defines, ' ', compileInfoStruct.Defines{i}];
end

includePath = [' -I ' '"' packDir '"'];
for i=2:(length(compileInfoStruct.IncPaths)-1)
    includePath = [includePath, ' -I "' compileInfoStruct.IncPaths{i} '"'];
end

mkString = sprintf("FUNCTION_NAME = %s", fcnName);
incPathsString = sprintf("PROJECT_INCLUDE_PATHS = %s", includePath);
definesString = sprintf("PROJECT_DEFINES = %s", defines);
fid = fopen(fullfile(targetFolderName, 'project', "fname.mk"), "w");
fprintf(fid, '%s\n', mkString);
fprintf(fid, '%s\n', incPathsString);
fprintf(fid, '%s\n', definesString);
fclose(fid);

% % Create the compiler.mk file in the folder
% mkString = sprintf("ARM_GCC = %s\n" + ...
%     "ARM_GPP = %s\n" + ...
%     "ARM_SIZE = %s\n" + ...
%     "BOOTGEN = %s" + ...
%     "\n" + ...
%     "USER_COMPILER_FLAGS = %s\n", ...
%     strrep(zEnv.armGppBin, 'g++', 'gcc'), ...
%     zEnv.armGppBin, ...
%     strrep(zEnv.armGppBin, 'g++', 'size'), ...
%     zEnv.bootgenBin, ...
%     strjoin(zSettings.userCompileFlags, ' '));
% fid = fopen(fullfile(targetFolderName, 'project', "compiler.mk"), "w");
% fprintf(fid, "%s", mkString);
% fclose(fid);

% Create the compiler.mk file in the folder
mkString = sprintf("ARM_GCC = %s\nARM_GPP = %s\nARM_SIZE = %s\nBOOTGEN = %s", ...
    strrep(zEnv.armGppBin, 'g++', 'gcc'), ...
    zEnv.armGppBin, ...
    strrep(zEnv.armGppBin, 'g++', 'size'), ...
    zEnv.bootgenBin);
fid = fopen(fullfile(targetFolderName, 'project', "compiler.mk"), "w");
fprintf(fid, "%s", mkString);
fclose(fid);


%% Generate Linker script
generateLinkerScript(fcnName, targetFolderName, iss, oss);
end