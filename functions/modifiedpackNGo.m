function modifiedpackNGo(buildInfoMatFileOrPath, varargin)
%PACKNGO - package all files in a buildInfo object into a zip file
%
%   packNGo(buildInfo) packs all files into zip file named
%   <model>.zip with a flat hierarchy.  An error is issued if
%   there are any files in different folders with the same
%   filename.
%
%   packNGo(buildInfo,propVals) packs the files according to the
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
%

% Copyright 2016-2021 The MathWorks, Inc.

% To maintain backward compatibility (packNGo used to unconditionally display the help), 
% packNGo displays the mhelp for all input except when a valid path to buildInfo.mat is 
% provided 

if nargin == 0 
    help('packNGo');
    return;
end

buildInfoMatFileOrPath = convertStringsToChars(buildInfoMatFileOrPath);
if ~ischar(buildInfoMatFileOrPath)
    help('packNGo');
    return;
end

% packNGo accepts either the BuildDir or the path to the buildInfo.mat
if isfile(buildInfoMatFileOrPath)
    buildInfoMatFile = buildInfoMatFileOrPath;
else
    buildInfoMatFile = fullfile(buildInfoMatFileOrPath, 'buildInfo.mat');
end

% After g1964849, we will error out for invalid input
[~,~, ext] = fileparts(buildInfoMatFile);
if ~isfile(buildInfoMatFile) || ~strcmp(ext, '.mat')
    help('packNGo');
    return;
end

modifiedInternalpackNGo(buildInfoMatFileOrPath, varargin{:});
end

