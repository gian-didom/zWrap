function [target_input_sizes_arm, target_output_sizes_arm] = getSizeCpp(buildInfo, codeInfoStruct, packDir)
%GETSIZECPP Summary of this function goes here
%   Detailed explanation goes here

%%

arm_compiler_path = '/opt/homebrew/bin/arm-none-eabi-g++';
nm_path = strrep(arm_compiler_path, 'g++', 'nm');

typesMap = codeInfoStruct.typesMap;
codeInfo = codeInfoStruct.codeInfo;
inPorts = codeInfo.Inports;
outPorts = codeInfo.Outports;
target_input_types = [];
target_output_types = [];

for j=1:numel(typesMap.HostTypes)
    if numel(typesMap.HostTypes(j).Name) > 0
fprintf("Host type %s is mapped to target type %s\n", typesMap.HostTypes(j).Name, codeInfo.Types(typesMap.TargetTypes(j)).Name);
    end
end


%% TODO: Check if it's "Name" or "Identifier"
for j=1:numel(inPorts)
    target_input_types = [target_output_types; string(inPorts(j).Type.Name)];
end


for j=1:numel(outPorts)
    target_output_types = [target_output_types; string(outPorts(j).Type.Name)];
end
%% STEP 1: Generate C++ source file
% The C source files only contains definition of the various structures,
% then using the arm-none-eabi-nm command, the size table is retrieved.

sourceLines = cell(0,1);
sourceLines{end+1}  = sprintf("#include ""%s_types.h""\n\n", buildInfo.ComponentName);

for j=1:numel(target_input_types)
sourceLines{end+1}  = sprintf("%s _%s;\n", target_input_types(j), target_input_types(j));
end

for j=1:numel(target_output_types)
sourceLines{end+1}  = sprintf("%s _%s;\n", target_output_types(j), target_output_types(j));
end

sourceLines{end+1} = sprintf("\n\nint main() {return 0;};");

file_to_save = 'getSizeNM.cpp';

fid = fopen(file_to_save, 'w');
fprintf(fid, '%s\n%s\n%s', sourceLines{:});
fclose(fid);

%% RUN COMPILATION
system(sprintf('%s -I %s -c getSizeNM.cpp -o getSizeNM.o', arm_compiler_path, packDir));

%% CHECK FILE ISZE

target_input_sizes_arm = zeros(numel(target_input_types),1);
target_output_sizes_arm = zeros(numel(target_output_types),1);
for j=1:numel(target_input_sizes_arm)
[~, outstring] = system(sprintf('%s -S getSizeNM.o | grep _%s', nm_path, target_input_types(j)));
splitOut = split(outstring);
target_input_sizes_arm(j) = hex2dec(splitOut{2});
end

for j=1:numel(target_output_sizes_arm)
[~, outstring] = system(sprintf('%s -S getSizeNM.o | grep _%s', nm_path, target_output_types(j)));
splitOut = split(outstring);
target_output_sizes_arm(j) = hex2dec(splitOut{2});
end




