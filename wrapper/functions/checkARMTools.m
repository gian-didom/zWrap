function checkARMTools()
global zEnv zSettings

switch computer
    case {'MACA64', 'GLNXA64'}
        execFile = 'arm-none-eabi-g++';
    case 'PCWIN64'
        execFile = 'arm-none-eabi-g++.exe';
end

if isfield(zSettings, 'customArmPath') && isfile(fullfile(zSettings.customArmPath, execFile))
    fprintf("ARM compiler found at %s\n", fullfile(zSettings.customArmPath, execFile));
    zEnv.armPath = zSettings.customArmPath;
    tmp = what(zEnv.armPath); zEnv.armPath = tmp.path;
    zEnv.armGppBin = fullfile(zEnv.armPath, execFile);
    zEnv.armGDBBin = fullfile(zEnv.armPath, strrep(execFile, 'g++', 'gdb'));
    return
end


% Tool is found in local tools folder
if  isfile(fullfile("tools", "arm-none-eabi", "bin", execFile))
    fprintf("ARM tools found at %s\n", fullfile("tools", "arm-none-eabi", "bin", execFile));
    zEnv.armPath = fullfile("tools", "arm-none-eabi", "bin");
    tmp = what(zEnv.armPath); zEnv.armPath = tmp.path;
    zEnv.armGppBin = fullfile(zEnv.armPath, execFile);
    zEnv.armGDBBin = fullfile(zEnv.armPath, strrep(execFile, 'g++', 'gdb'));
    return
end

uniquePathList = getPossibleToolPaths();

% Check if executable exists.
foundExec = cellfun(@(x) isfile(fullfile(x, execFile)), uniquePathList);
if not(any(foundExec))
    warning("ARM tools not found. Please install from official website.")
    zEnv.armPath = "";
    zEnv.armGppBin = "";
    zEnv.armGDBBin = "";
    return
end

% If we're here, we found the compiler
if sum(foundExec) > 1
    % Found multiple ARM compilers. Taking the first.
    warning("Found multiple ARM compilers. ARM compiler set to %s", ...
        fullfile(uniquePathList{find(foundExec,1)}));
    zEnv.armPath = fullfile(uniquePathList{find(foundExec,1)});
    tmp = what(zEnv.armPath); zEnv.armPath = tmp.path;
    zEnv.armGppBin = fullfile(zEnv.armPath, execFile);
    zEnv.armGDBBin = fullfile(zEnv.armPath, strrep(execFile, 'g++', 'gdb'));
else
    % Found a unique ARM compiler.
    fprintf("Found ARM compiler at %s\n", ...
        fullfile(uniquePathList{find(foundExec,1)}));
    zEnv.armPath = fullfile(uniquePathList{find(foundExec,1)});
    tmp = what(zEnv.armPath); zEnv.armPath = tmp.path;
    zEnv.armGppBin = fullfile(zEnv.armPath, execFile);
    zEnv.armGDBBin = fullfile(zEnv.armPath, strrep(execFile, 'g++', 'gdb'));

end
