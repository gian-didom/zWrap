function checkGNUMake()
global zEnv zSettings



switch computer
    case {'MACA64', 'GLNXA64'}
        execFile = 'make';
    case 'PCWIN64'
        execFile = 'make.exe';
end

if isfield(zSettings, 'customMakePath') && isfile(fullfile(zSettings.customMakePath, execFile))
    fprintf("GNU make found at %s\n", fullfile(zSettings.customMakePath, execFile));
    zEnv.makePath = zSettings.customMakePath;
    
    return
end

% Tool is found in local tools folder
if  isfile(fullfile("tools", "make", "bin", execFile))
    fprintf("GNU make found at %s\n", fullfile("tools", "make", "bin", execFile));
    zEnv.makePath = fullfile("tools", "make", "bin");
    tmp = what(zEnv.makePath); zEnv.makePath = tmp.path;
    
    return
end


uniquePathList = getPossibleToolPaths();

% Check if executable exists.
foundExec = cellfun(@(x) isfile(fullfile(x, execFile)), uniquePathList);
if not(any(foundExec))
    warning("GNU make not found. Please install GNU make from official website. " + ...
        "zWrap can run, but you won't be able to run makefiles.")
    zEnv.makePath = "";

    
    return
end


% If we're here, we found the compiler
if sum(foundExec) > 1
    % Found multiple makes. Taking the first.
    warning("Found multiple GNU make tools. GNU make set to %s", ...
        fullfile(uniquePathList{find(foundExec,1)}));

    fprintf("Found GNU make at %s\n", ...
        fullfile(uniquePathList{find(foundExec,1)}));

    zEnv.makePath = fullfile(uniquePathList{find(foundExec,1)});
    tmp = what(zEnv.makePath); zEnv.makePath = tmp.path;
    
else
    % Found a unique make.
    fprintf("Found GNU make at %s\n", ...
        fullfile(uniquePathList{find(foundExec,1)}));

    zEnv.makePath = fullfile(uniquePathList{find(foundExec,1)});
    tmp = what(zEnv.makePath); zEnv.makePath = tmp.path;
    

end
