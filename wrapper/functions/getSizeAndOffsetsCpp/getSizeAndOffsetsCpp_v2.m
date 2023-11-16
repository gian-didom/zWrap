function [fullInputSizeGCC, fullOutputSizeGCC] = ...
    getSizeAndOffsetsCpp_v2(buildInfo, codedInputs, codedOutputs, packDir, echo)
%GETSIZECPP Summary of this function goes here
%   Detailed explanation goes here
global zEnv

if nargin == 4
    echo = false;
end

%% TODO: FIX FOR ARRAY OF STRUCTURES. IN THIS CASE, WHAT IT SHOULD BE DONE IS TO MAP ALSO THE MEMORY OF A SINGLE INSTANCE.

arm_compiler_path = zEnv.armGppBin;
% nm_path = strrep(arm_compiler_path, 'g++', 'nm');
gdb_path = zEnv.armGDBBin;

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

% ============================================================ Includes
% Include directive for fcnname_types.h
sourceLines = cell(0,1);
if isfile(fullfile(packDir, sprintf("%s_types.h", buildInfo.ComponentName)))
sourceLines{end+1}  = sprintf("#include ""%s_types.h""\n\n", buildInfo.ComponentName);
end

% Include directive for fcnname.h
if isfile(fullfile(packDir, sprintf("%s.h", buildInfo.ComponentName)))
sourceLines{end+1}  = sprintf("#include ""%s.h""\n\n", buildInfo.ComponentName);
end

% Include directive for rtwtypes.h - if not included already (Simulink)
sourceLines{end+1}  = sprintf("\n#ifndef RTWTYPES_H\n");
sourceLines{end+1}  = sprintf("#include ""rtwtypes.h""\n\n");
sourceLines{end+1}  = sprintf("#endif\n\n");


sourceLines{end+1} = sprintf("namespace coder {");

% ================= Full input structure definition - in namespace coder
sourceLines{end+1} = sprintf("struct inputStructure {");
for j=1:numel(codedInputs)
    if codedInputs(j).size > 1
        sourceLines{end+1}  = sprintf("%s _%s[%i];\n", codedInputs(j).type, codedInputs(j).name, codedInputs(j).size);
    else
        sourceLines{end+1}  = sprintf("%s _%s;\n", codedInputs(j).type, codedInputs(j).name);

    end
end
sourceLines{end+1} = sprintf("};\n");
% Input structure declaration
sourceLines{end+1} = sprintf("inputStructure FULL_INPUT_STRUCT;\n"); 


% ===================================== Full output structure definition 
sourceLines{end+1} = sprintf("struct {");
for j=1:numel(codedOutputs)
    if codedOutputs(j).size > 1
        sourceLines{end+1}  = sprintf("%s _%s[%i];\n", codedOutputs(j).type, codedOutputs(j).name, codedOutputs(j).size);
    else
        sourceLines{end+1}  = sprintf("%s _%s;\n", codedOutputs(j).type, codedOutputs(j).name);

    end
end
% Output structure declaration
sourceLines{end+1} = sprintf("} FULL_OUTPUT_STRUCT;\n");    

% =========================================================== Empty main
sourceLines{end+1} = sprintf("\n\nint main() {return 0;};");

% ================================================== Close and save file
sourceLines{end+1} = sprintf("}"); 
CPP_test_file = fullfile('temp', 'getSizeAndOffsetsGDB.cpp');

fid = fopen(CPP_test_file, 'w');
fprintf(fid, '%s\n%s\n%s', sourceLines{:});
fclose(fid);

%% RUN COMPILATION - WITH DEBUG OPTIONS FOR GDB

output_test_file = fullfile('temp', 'getSizeAndOffsetsGDB.o');

fprintf('Running "%s" -I "%s" -c "%s" -o "%s" -g\n', ...
    arm_compiler_path, ...
    packDir, ...
    CPP_test_file,  ...
    output_test_file);
[compilationStatus, ~] = system(sprintf('"%s" -I "%s" -O0 -c "%s" -o "%s" -g', ...
                                        arm_compiler_path, ...
                                        packDir, ...
                                        CPP_test_file,  ...
                                        output_test_file), ... 
                               '-echo');
assert(compilationStatus==0, ...
    "Error during compilation. Please check the console output.");

%% Retrieve sized through GDB

%================================================================= INPUTS
fprintf('\nRunning %s', sprintf('"%s" -q "%s" --batch --x "%s"\n', ...
    gdb_path, output_test_file, fullfile('support', 'GDB_InputStructCommand.txt')));

[outFlag, outstring] = system(sprintf('"%s" -q "%s" --batch --x "%s"', ...
    gdb_path, output_test_file, fullfile('support', 'GDB_InputStructCommand.txt')));
assert(outFlag == 0, "Error during GDB read.");

if echo; disp(outstring); fprintf("\n\n\n\n"); end
outlines = splitlines(outstring);
fullInputSizeGCC = str2double(regexp(outlines{end-2}, '([0-9]+)', 'match'));
if isempty(fullInputSizeGCC); fullInputSizeGCC = 0; end

%================================================================ OUTPUTS
fprintf('\nRunning %s', sprintf('"%s" -q "%s" --batch --x "%s"\n', ...
    gdb_path, output_test_file, fullfile('support', 'GDB_OutputStructCommand.txt')));
[outFlag, outstring] = system(sprintf('"%s" -q "%s" --batch --x "%s"', ...
    gdb_path, output_test_file, fullfile('support', 'GDB_OutputStructCommand.txt')));

assert(outFlag == 0, "Error during GDB read.");

if echo; disp(outstring); end
outlines = splitlines(outstring);
fullOutputSizeGCC = str2double(regexp(outlines{end-2}, '([0-9]+)', 'match'));
if isempty(fullOutputSizeGCC); fullOutputSizeGCC = 0; end

%% FINAL STEP: Clean

delete(CPP_test_file);  
delete(output_test_file)

return



