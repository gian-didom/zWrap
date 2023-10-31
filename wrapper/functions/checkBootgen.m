function checkBootgen()
global zEnv zSettings



switch computer
    case {'MACA64', 'GLNXA64'}
        execFile = 'bootgen';
    case 'PCWIN64'
        execFile = 'bootgen.exe';
end

% User specified the tool path and the tool is found inside
if isfield(zSettings, 'customBootgenPath') && isfile(fullfile(zSettings.customBootgenPath, execFile))
    fprintf("bootgen found at %s\n", fullfile(zSettings.customBootgenPath, execFile));
    zEnv.bootgenPath = zSettings.customBootgenPath;
    tmp = what(zEnv.bootgenPath); zEnv.bootgenPath = tmp.path;
    zEnv.bootgenBin = fullfile(zEnv.bootgenPath, execFile);
    return
end

% Tool is found in local tools folder
if  isfile(fullfile("tools", "bootgen", execFile))
    fprintf("bootgen found at %s\n", fullfile("tools", "bootgen", execFile));
    zEnv.bootgenPath = fullfile("tools", "bootgen");
    tmp = what(zEnv.bootgenPath); zEnv.bootgenPath = tmp.path;
    zEnv.bootgenBin = fullfile(zEnv.bootgenPath, execFile);
    return
end



uniquePathList = getPossibleToolPaths();


% Check if executable exists.
foundExec = cellfun(@(x) isfile(fullfile(x, execFile)), uniquePathList);
if not(any(foundExec))
    warning("bootgen not found. Please install bootgen from official website. " + ...
        "zWrap can run, but you won't be able to generate the SD card image.")
    zEnv.bootgenPath = '';
    zEnv.bootgenBin = '';
    
    return
end


% If we're here, we found the compiler
if sum(foundExec) > 1
    % Found multiple ARM compilers. Taking the first.
    warning("Found multiple bootgen tools. bootgen set to %s", ...
        fullfile(uniquePathList{find(foundExec,1)}));

    fprintf("Found bootgen at %s\n", ...
        fullfile(uniquePathList{find(foundExec,1)}));

    zEnv.bootgenPath = fullfile(uniquePathList{find(foundExec,1)});
    tmp = what(zEnv.bootgenPath); zEnv.bootgenPath = tmp.path;
    zEnv.bootgenBin = fullfile(zEnv.bootgenPath, execFile);
    
else
    % Found a unique bootgen.
    fprintf("Found bootgen at %s\n", ...
        fullfile(uniquePathList{find(foundExec,1)}));
    zEnv.bootgenPath = fullfile(uniquePathList{find(foundExec,1)});
    tmp = what(zEnv.bootgenPath); zEnv.bootgenPath = tmp.path;
    zEnv.bootgenBin = fullfile(zEnv.bootgenPath, execFile);
    
end
