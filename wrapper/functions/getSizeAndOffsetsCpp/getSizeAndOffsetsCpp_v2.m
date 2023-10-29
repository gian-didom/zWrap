function [fullInputSizeGCC, fullOutputSizeGCC] = ...
    getSizeAndOffsetsCpp_v2(buildInfo, codedInputs, codedOutputs, packDir, echo)
%GETSIZECPP Summary of this function goes here
%   Detailed explanation goes here
global zEnv

if nargin == 4
    echo = false;
end
%% TODO: ESCAPE CHARACTERS!!!!

%% TODO: FIX FOR ARRAY OF STRUCTURES. IN THIS CASE, WHAT IT SHOULD BE DONE IS TO MAP ALSO THE MEMORY OF A SINGLE INSTANCE.
switch computer
    case {'MACA64', 'GLNXA64'}
        compilerFile = 'arm-none-eabi-g++';
    case 'PCWIN64'
        compilerFile = 'arm-none-eabi-g++.exe';
end

arm_compiler_path = fullfile(zEnv.armPath, compilerFile);
% nm_path = strrep(arm_compiler_path, 'g++', 'nm');
gdb_path = strrep(arm_compiler_path, 'g++', 'gdb');

assert(isfile(arm_compiler_path), 'Error in setting ARM g++ path.');
assert(isfile(arm_compiler_path), 'Error in setting ARM gdb path.');
%% STEP 0: Clean
if isfile('temp/getSizeAndOffsetsGDB.cpp')
    delete('temp/getSizeAndOffsetsGDB.cpp');
end

if isfile('temp/getSizeAndOffsetsGDB.o')
    delete('temp/getSizeAndOffsetsGDB.o')
end


%% STEP 1: Generate C++ source file
% The C source files only contains definition of the various structures,
% then using the arm-none-eabi-nm command, the size table is retrieved.

sourceLines = cell(0,1);
if isfile(fullfile(packDir, sprintf("%s_types.h", buildInfo.ComponentName)))
sourceLines{end+1}  = sprintf("#include ""%s_types.h""\n\n", buildInfo.ComponentName);
end

if isfile(fullfile(packDir, sprintf("%s.h", buildInfo.ComponentName)))
sourceLines{end+1}  = sprintf("#include ""%s.h""\n\n", buildInfo.ComponentName);
end

sourceLines{end+1}  = sprintf("\n#ifndef RTWTYPES_H\n");
sourceLines{end+1}  = sprintf("#include ""rtwtypes.h""\n\n");
sourceLines{end+1}  = sprintf("#endif\n\n");

% Full input
sourceLines{end+1} = sprintf("namespace coder {");
sourceLines{end+1} = sprintf("struct inputStructure {");
for j=1:numel(codedInputs)
    if codedInputs(j).size > 1
        sourceLines{end+1}  = sprintf("%s _%s[%i];\n", codedInputs(j).type, codedInputs(j).name, codedInputs(j).size);
    else
        sourceLines{end+1}  = sprintf("%s _%s;\n", codedInputs(j).type, codedInputs(j).name);

    end
end
sourceLines{end+1} = sprintf("};\n");

sourceLines{end+1} = sprintf("inputStructure FULL_INPUT_STRUCT;\n");

% Full output
sourceLines{end+1} = sprintf("struct {");
for j=1:numel(codedOutputs)
    if codedOutputs(j).size > 1
        sourceLines{end+1}  = sprintf("%s _%s[%i];\n", codedOutputs(j).type, codedOutputs(j).name, codedOutputs(j).size);
    else
        sourceLines{end+1}  = sprintf("%s _%s;\n", codedOutputs(j).type, codedOutputs(j).name);

    end
end
sourceLines{end+1} = sprintf("} FULL_OUTPUT_STRUCT;\n");


sourceLines{end+1} = sprintf("\n\nint main() {return 0;};");

sourceLines{end+1} = sprintf("}"); 
CPP_test_file = fullfile('temp', 'getSizeAndOffsetsGDB.cpp');

fid = fopen(CPP_test_file, 'w');
fprintf(fid, '%s\n%s\n%s', sourceLines{:});
fclose(fid);

%% RUN COMPILATION - WITH DEBUG OPTIONS FOR GDB
output_test_file = fullfile('temp', 'getSizeAndOffsetsGDB.o');

fprintf('Running %s -I "%s" -c %s -o %s -g\n', ...
    arm_compiler_path, ...
    packDir, ...
    CPP_test_file,  ...
    output_test_file);
[compilationStatus, ~] = system(sprintf('%s -I %s -O0 -c %s -o %s -g', ...
                                        arm_compiler_path, ...
                                        packDir, ...
                                        CPP_test_file,  ...
                                        output_test_file), ... 
                               '-echo');
assert(compilationStatus==0, "Error during compilation. Please check the console output.");

%% Do for FULL_INPUT_STRUCT
fprintf('\nRunning %s', sprintf("%s -q %s --batch --x %s\n", ...
    gdb_path, output_test_file, fullfile('support', 'GDB_InputStructCommand.txt')));

[~, outstring] = system(sprintf("%s -q %s --batch --x %s", ...
    gdb_path, output_test_file, fullfile('support', 'GDB_InputStructCommand.txt')));

if echo; fprintf(outstring); fprintf("\n\n\n\n"); end
outlines = splitlines(outstring);
fullInputSizeGCC = str2double(regexp(outlines{end-2}, '([0-9]+)', 'match'));
if isempty(fullInputSizeGCC); fullInputSizeGCC = 0; end

% [~, outstring] = system(sprintf("%s -q getSizeAndOffsetsGDB.o --batch --ex 'ptype /o coder::FULL_INPUT_STRUCT._%s' --ex exit", gdb_path, codedInputs(1).name));
% fprintf(outstring);
fprintf('\nRunning %s', sprintf("%s -q %s --batch --x %s\n", ...
    gdb_path, output_test_file, fullfile('support', 'GDB_OutputStructCommand.txt')));
[~, outstring] = system(sprintf("%s -q %s --batch --x %s", ...
    gdb_path, output_test_file, fullfile('support', 'GDB_OutputStructCommand.txt')));

if echo; fprintf(outstring); end
outlines = splitlines(outstring);
fullOutputSizeGCC = str2double(regexp(outlines{end-2}, '([0-9]+)', 'match'));
if isempty(fullOutputSizeGCC); fullOutputSizeGCC = 0; end

%% FINAL STEP: Clean
delete(CPP_test_file);
delete(output_test_file)



return



