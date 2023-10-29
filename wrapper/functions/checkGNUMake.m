function checkGNUMake()
global zEnv zSettings

execName = 'make';

if isfield(zSettings, 'makePath') && isfile(fullfile(zSettings.makePath, execName))
    fprintf("GNU make found at %s", fullfile(zSettings.makePath, execName));
    zEnv.makePath = zSettings.makePath;
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
foundExec = cellfun(@(x) isfile(fullfile(x, execName)), pathList);
if not(any(foundExec))
warning("GNU make not found. Please install GNU make from official website. " + ...
    "zWrap can run, but you won't be able to run makefiles.")
zEnv.makePath = false;
return
end


% If we're here, we found the compiler
if sum(foundExec) > 1
    % Found multiple ARM compilers. Taking the first.
    warning("Found multiple GNU make tools. GNU make set to %s", ...
        pathList{foundExec}, fullfile(pathList{find(foundExec,1)}));
    zEnv.makePath = fullfile(pathList{find(foundExec,1)});
else
    % Found a unique ARM compiler.
    fprintf("Found GNU make at %s\n", ...
        fullfile(pathList{find(foundExec,1)}));
    zEnv.makePath = fullfile(pathList{find(foundExec,1)});

end
