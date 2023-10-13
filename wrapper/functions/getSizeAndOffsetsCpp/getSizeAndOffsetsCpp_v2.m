function [fullInputSizeGCC, fullOutputSizeGCC] = ...
    getSizeAndOffsetsCpp_v2(buildInfo, codedInputs, codedOutputs, packDir, echo)
%GETSIZECPP Summary of this function goes here
%   Detailed explanation goes here
if nargin == 4
    echo = false;
end
%% TODO: ESCAPE CHARACTERS!!!!

%% TODO: FIX FOR ARRAY OF STRUCTURES. IN THIS CASE, WHAT IT SHOULD BE DONE IS TO MAP ALSO THE MEMORY OF A SINGLE INSTANCE.

arm_compiler_path = '/opt/homebrew/bin/arm-none-eabi-g++';
nm_path = strrep(arm_compiler_path, 'g++', 'nm');
gdb_path = strrep(arm_compiler_path, 'g++', 'gdb');

%% STEP 1: Generate C++ source file
% The C source files only contains definition of the various structures,
% then using the arm-none-eabi-nm command, the size table is retrieved.

sourceLines = cell(0,1);
sourceLines{end+1}  = sprintf("#include ""%s_types.h""\n\n", buildInfo.ComponentName);

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
file_to_save = fullfile('out', 'getSizeAndOffsetsGDB.cpp');

fid = fopen(file_to_save, 'w');
fprintf(fid, '%s\n%s\n%s', sourceLines{:});
fclose(fid);

%% RUN COMPILATION - WITH DEBUG OPTIONS FOR GDB
fprintf('Running %s -I "%s" -c out/getSizeAndOffsetsGDB.cpp -o out/getSizeAndOffsetsGDB.o -g', arm_compiler_path, packDir);
system(sprintf('%s -I %s -O0 -c out/getSizeAndOffsetsGDB.cpp -o out/getSizeAndOffsetsGDB.o -g', arm_compiler_path, packDir), '-echo');


%% Do for FULL_INPUT_STRUCT
fprintf('\nRunning %s', sprintf("%s -q out/getSizeAndOffsetsGDB.o --batch --ex 'ptype /o coder::FULL_INPUT_STRUCT' --ex exit\n", gdb_path));

[~, outstring] = system(sprintf("%s -q out/getSizeAndOffsetsGDB.o --batch --ex 'ptype /o coder::FULL_INPUT_STRUCT' --ex exit", gdb_path));
if echo; fprintf(outstring); fprintf("\n\n\n\n"); end
outlines = splitlines(outstring);
fullInputSizeGCC = str2double(regexp(outlines{end-2}, '([0-9]+[0-9])', 'match'));
if isempty(fullInputSizeGCC); fullInputSizeGCC = 0; end

% [~, outstring] = system(sprintf("%s -q getSizeAndOffsetsGDB.o --batch --ex 'ptype /o coder::FULL_INPUT_STRUCT._%s' --ex exit", gdb_path, codedInputs(1).name));
% fprintf(outstring);
[~, outstring] = system(sprintf("%s -q out/getSizeAndOffsetsGDB.o --batch --ex 'ptype /o coder::FULL_OUTPUT_STRUCT' --ex exit", gdb_path));
if echo; fprintf(outstring); end
outlines = splitlines(outstring);
fullOutputSizeGCC = str2double(regexp(outlines{end-2}, '([0-9]+[0-9])', 'match'));
if isempty(fullOutputSizeGCC); fullOutputSizeGCC = 0; end

return



