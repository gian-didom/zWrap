function [outputArg1,outputArg2] = zWrap(varargin)
clear zSettings;
clear zEnv;
global zSettings zEnv

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
addpath(genpath('classes'));
addpath(genpath('functions'));

fprintbf("Checking dependencies...\n");


%% Parse inputs
zSettings = parsezArgs(varargin{:});

%% STEP 0.1: Check if tools are available
checkDependencies();

%% TODO: Alternative, give CodeInfo and then base everything on that directory
coder_project_path = zSettings.path;
projectDir = what(coder_project_path);
coder_project_path = projectDir.path;

%% LOAD INFO FILES

fprintbf('Loading coded project information...');
buildInfoStruct = load(fullfile(coder_project_path, 'buildInfo.mat'));
codeInfoStruct = load(fullfile(coder_project_path, 'codeInfo.mat'));
compileInfoStruct = load(fullfile(coder_project_path, 'compileInfo.mat'));

buildInfo = buildInfoStruct.buildInfo;
codeInfo = codeInfoStruct.codeInfo;
printDone();

% Create packNGo including all headers
fprintbf('Packing code including all headers... ');
zipName = fullfile(coder_project_path, ...
    strcat(buildInfo.ComponentName, ".zip"));
packDir = fullfile(coder_project_path, 'pack');

if (exist(packDir, 'dir'))
    rmdir(packDir, 's');
end
modifiedpackNGo(fullfile(coder_project_path, 'buildInfo.mat'), ...
    'minimalHeaders', false, ...
    'fileName', zipName);
unzip(zipName, packDir);
fprintbf('All code succesfully packed in %s', packDir);
printDone();


%% GET INPUT OBJECT
fprintbf('Building interface structure objects...');

iss = fullInterfaceStructure(codeInfo, 'input');
iss.getTotalSize();
iss.getTotalSizePadded();
iss.printTree();
fprintf('\n\n\n');
oss = fullInterfaceStructure(codeInfo, 'output');
oss.getTotalSize();
oss.getTotalSizePadded()
oss.printTree();
printDone();

% Get padding thanks to  GDB
fprintbf('Compiling and checking with gcc...\n');
%% RETRIEVE INPUT AND OUTPUT INFORMATION
fprintbf('Analyzing function inputs...\n');
[numInputs, nameInputs, typeInputs, sizeInputs] = getNumberOfInputs(codeInfo);       % Inputs
printDone();

fprintbf('Analyzing function outputs...\n');
[numOutputs, nameOutputs, typeOutputs, sizeOutputs] = getNumberOfOutputs(codeInfo);   % Outputs
printDone();

codedInputs = arrayfun(@(a,b,c) struct('name', a, 'type', b', 'size', c), ...
    nameInputs, typeInputs, sizeInputs);
codedOutputs = arrayfun(@(a,b,c) struct('name', a, 'type', b', 'size', c), ...
    nameOutputs, typeOutputs, sizeOutputs);

% Clean the ones not used in iss
% index_found = arrayfun(@(s) any(strcmp(s.name, vertcat(iss.Children.argNames))), codedInputs);
% codedInputs = codedInputs(index_found);

echo = true;
[GCCInputSize, GCCOutputSize] = getSizeAndOffsetsCpp_v2(buildInfo, codedInputs, codedOutputs, packDir, echo);


assert(GCCInputSize == iss.getTotalSizePadded(), "Error: input size mismatch. Try again with the --pack option.");
fprintbf('✓ Input size check successful.\n');
assert(GCCOutputSize == oss.getTotalSizePadded(), "Error: output size mismatch. Try again with the --pack option.");
fprintbf('✓ Output size check successful.\n');

% Note: this size accounts for inter-struct alignment;
% however, for readability purposes, everything will then be packed in a
% big INPUT_STRUCT that could be slightly bigger for alignment purposes.

%% GENERATE PROJECT FOLDER
fprintbf('Generating project folder...\n');
targetFolderName = fullfile('out', sprintf("z%s", iss.fcnName));


% 1. Create project folder
if exist(targetFolderName, 'dir')
    if zSettings.y
        usrInput = 'y';
    else
        usrInput = input(sprintf("<strong>Folder %s already exists, overwrite?</strong> [Y/n/k] [k]\n", ...
            targetFolderName), "s");
    end


    switch usrInput

        case {'Y', 'y'}
            warning('off', 'MATLAB:rmpath:DirNotFound');
            rmpath(genpath(targetFolderName))
            rmdir(targetFolderName, 's')
            warning('on', 'MATLAB:rmpath:DirNotFound');

        case {'K', 'k', ''}
            new_targetFolderName = targetFolderName;
            j=1;
            while exist(new_targetFolderName, "dir")
                new_targetFolderName = sprintf("%s%i", targetFolderName, j);
                j = j+1;
            end
            targetFolderName = new_targetFolderName;

        otherwise
            fprintf("Aborting.");
            return
    end

end

mkdir(targetFolderName);
mkdir(fullfile(targetFolderName, "generated"));
mkdir(fullfile(targetFolderName, "simulink"));
mkdir(fullfile(targetFolderName, "project"));

addpath(genpath(targetFolderName));
fprintbf("Project folder generated at %s\n", targetFolderName);


%% GENERATE INPUT STREAM PARSER
% The inputs should be mapped in the shared memory region.

fprintbf('Generating input stream encoding and test function...');
iss.generateMATLABFunction(fullfile(targetFolderName, 'simulink'));
iss.generateDecoderFunction(fullfile(targetFolderName, 'simulink'), true);
printDone();

fprintbf('Generating output stream decoding and test function...');
oss.generateDecoderFunction(fullfile(targetFolderName, 'simulink'));
oss.generateMATLABFunction(fullfile(targetFolderName, 'simulink'), true);
printDone();

fprintbf('Generating C++ memory structure mapping header...');
generateCppMemoryMapping(iss, oss, fullfile(targetFolderName, 'generated', 'memorymap.h'));
printDone();

fprintbf('Generating C++ entry point header and function...');
generateCppCallTemplate(iss, oss, fullfile(targetFolderName, 'generated', 'callFunction.c'));
generateCppCallHeader(iss, oss, fullfile(targetFolderName, 'generated', 'callFunction.h'));
printDone();


%% GENERATE BOARD BUILD
boardName = 'zedboard';
pathsToRemove = split(genpath('boards'), ':');

% rmpath(genpath('boards'));
for j=1:numel(pathsToRemove)
    pth = pathsToRemove{j};
    if contains(path, strcat(pth, '\n'))
        rmpath(pth)
    end
end

addpath(genpath(fullfile('boards', boardName)));
buildProjectDir(iss.fcnName, targetFolderName, packDir, iss, oss);

% 8. Move the calling function template to the proper directory

% fprintbf('Customizing linker script...\n');

% fprintbf('Generating makefile for ARM-Core0...\n');
% fprintbf('Generating makefile for ARM-Core1...\n');

% fprintbf('Running makefile for ARM-Core0...\n');
% fprintbf('Running makefile for ARM-Core1...\n');
% fprintbf('.elf files succesfully generated!\n');
% fprintbf('Generating boot image...\n');

% bootImagePath = fullfile(coder_project_path, 'BOOT.bin');
% fprintbf('BOOT.bin image succesfully generated at %s\n', bootImagePath);

%% GENERATE INTERFACES
fprintbf('Generating Simulink block...\n')
fprintbf('Generating Simulink library...\n')
SimulinkLibraryPath = fullfile(targetFolderName, 'simulink', sprintf('%s.slx', iss.fcnName));
generateSimulinkLibrary(iss, oss, SimulinkLibraryPath);
fprintbf('Simulink library succesfully created at %s!\n', SimulinkLibraryPath)

%% RUN makefiles
buildVar = 'Debug';
[makeFlag] = system(sprintf("cd %s %s %s", ...
                                fullfile(targetFolderName, "project", strcat(iss.fcnName, "_multicore_system"), buildVar), ...
                                cmdsep, ...
                                zEnv.makeBin), ...
                        "-echo");
%% RUN TESTS

% Test 1: hard-coded memory address is the one obtained from the Core 1
% disassembly (needs .elf file compilation)

%% CLEAR
clear zSettings;
fprintbf('Process completed. Insert the SD card in the ZedBoard and run a Simulink test case with the provided block.\n')
end

function printDone
fprintbf('\t✓ Done.\n');
end