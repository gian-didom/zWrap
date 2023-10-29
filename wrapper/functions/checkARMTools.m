function checkARMTools()
global zEnv zSettings

if isfield(zSettings, 'armPath') && isfile(fullfile(zSettings.armPath, 'arm-none-eabi-g++'))
    fprintf("Arm compiler found at %s", fullfile(zSettings.armPath, 'arm-none-eabi-g++'));
    zEnv.armPath = zSettings.armPath;
    return
end

switch computer
    case 'MACA64'
        % MacOS
        pathList = { ...
            "/opt/homebrew/bin";
            "/opt/homebrew/sbin";
            "/usr/local/bin";
            "/usr/bin";
            "/bin";
            "/usr/sbin";
            "/sbin";
            "ops/X11/bin";
            "/Library/Apple/usr/bin";
            };

    case 'PCWIN64'
        % Windows

    case 'GLNXA64'
        % Linux
    
end

% Check if executable exists.
foundExec = cellfun(@(x) isfile(fullfile(x, 'arm-none-eabi-g++')), pathList);
assert(any(foundExec), "ARM compiler not found. Please install ARM compiler from ARM website.")

% If we're here, we found the compiler
if sum(foundExec) > 1
    % Found multiple ARM compilers. Taking the first.
    warning("Found multiple ARM compilers. ARM compiler set to %s", ...
        pathList{foundExec}, fullfile(pathList{find(foundExec,1)}));
    zEnv.armPath = fullfile(pathList{find(foundExec,1)});
else
    % Found a unique ARM compiler.
    fprintf("Found ARM compiler at %s\n", ...
        fullfile(pathList{find(foundExec,1)}));
    zEnv.armPath = fullfile(pathList{find(foundExec,1)});

end
