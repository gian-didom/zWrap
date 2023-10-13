buildFile = load('structInput/codegen/lib/structinput/codeInfo.mat');

typesMap = buildFile.typesMap;
codeInfo = buildFile.codeInfo;

target_input_types = [];

for j=1:numel(typesMap.HostTypes)
    if numel(typesMap.HostTypes(j).Name) > 0
fprintf("Host type %s is mapped to target type %s\n", typesMap.HostTypes(j).Name, codeInfo.Types(typesMap.TargetTypes(j)).Name);
target_input_types = [target_input_types; codeInfo.Types(typesMap.TargetTypes(j)).Name]
    end
end