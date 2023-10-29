function checkBootgen()
global zEnv zSettings

execName = 'bootgen';

if isfield(zSettings, 'bootgenPath') && isfile(fullfile(zSettings.bootgenPath, execName))
    fprintf("bootgen found at %s", fullfile(zSettings.bootgenPath, execName));
    zEnv.bootgenPath = zSettings.bootgenPath;
    return
end

switch computer
    case 'MACA64'
        % MacOS
        % Since typically bootgen is not found in the typical paths, we can
        % look at the path variable as set by zsh. In order to do this, zsh
        % should first load the .zprofile and then we can echo the path
        
        [code, zshPATH] = system("source ~/.zprofile && echo $PATH");
        pathList = split(zshPATH, ':');
    
        pathList = vertcat(pathList, { ...
            "/opt/homebrew/bin";
            "/opt/homebrew/sbin";
            "/usr/local/bin";
            "/usr/bin";
            "/bin";
            "/usr/sbin";
            "/sbin";
            "ops/X11/bin";
            "/Library/Apple/usr/bin";
            });

        pathList = cellfun(@(x) char(x), pathList, 'UniformOutput',false);
        
        uniquePathList = {};
        for j=1:numel(pathList)
            pth = pathList{j};
            if find(strcmp(pth, pathList), 1) == j
                uniquePathList = vertcat(uniquePathList, pth);
            end
        end
        
        % Don't deal with uniques, it's ok.

    case 'PCWIN64'
        % Windows

    case 'GLNXA64'
        % Linux
    
end

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
        pathList{foundExec}, fullfile(pathList{find(foundExec,1)}));
    zEnv.bootgenPath = fullfile(pathList{find(foundExec,1)});
else
    % Found a unique ARM compiler.
    fprintf("Found bootgen at %s\n", ...
        fullfile(pathList{find(foundExec,1)}));
    zEnv.bootgenPath = fullfile(pathList{find(foundExec,1)});

end
