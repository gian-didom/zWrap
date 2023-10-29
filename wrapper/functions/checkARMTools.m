function checkARMTools()
global zEnv zSettings

switch computer
    case {'MACA64', 'GLNXA64'}
        execFile = 'arm-none-eabi-g++';
    case 'PCWIN64'
        execFile = 'arm-none-eabi-g++.exe';
end

if isfield(zSettings, 'customArmPath') && isfile(fullfile(zSettings.customArmPath, execFile))
    fprintf("ARM compiler found at %s", fullfile(zSettings.customArmPath, execFile));
    zEnv.armPath = zSettings.customArmPath;
    return
end

uniquePathList = getPossibleToolPaths();

% Check if executable exists.
foundExec = cellfun(@(x) isfile(fullfile(x, execFile)), uniquePathList);
assert(any(foundExec), "ARM compiler not found. Please install ARM compiler from ARM website.")

% If we're here, we found the compiler
if sum(foundExec) > 1
    % Found multiple ARM compilers. Taking the first.
    warning("Found multiple ARM compilers. ARM compiler set to %s", ...
       fullfile(uniquePathList{find(foundExec,1)}));
    zEnv.armPath = fullfile(uniquePathList{find(foundExec,1)});
else
    % Found a unique ARM compiler.
    fprintf("Found ARM compiler at %s\n", ...
        fullfile(uniquePathList{find(foundExec,1)}));
    zEnv.armPath = fullfile(uniquePathList{find(foundExec,1)});

end
