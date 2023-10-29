function checkBootgen()
global zEnv zSettings

execName = 'bootgen';

if isfield(zSettings, 'bootgenPath') && isfile(fullfile(zSettings.customBootgenPath, execName))
    fprintf("bootgen found at %s", fullfile(zSettings.customBootgenPath, execName));
    zEnv.bootgenPath = zSettings.customBootgenPath;
    return
end

        

uniquePathList = getPossibleToolPaths();


% Check if executable exists.
foundExec = cellfun(@(x) isfile(fullfile(x, execName)), uniquePathList);
if not(any(foundExec))
warning("bootgen not found. Please install bootgen from official website. " + ...
    "zWrap can run, but you won't be able to generate the SD card image.")
zEnv.bootgenPath = false;
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
else
    % Found a unique ARM compiler.
    fprintf("Found bootgen at %s\n", ...
        fullfile(uniquePathList{find(foundExec,1)}));
    zEnv.bootgenPath = fullfile(uniquePathList{find(foundExec,1)});

end
