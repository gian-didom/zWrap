function uniquePathList = getPossibleToolPaths()
global zSettings



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

    case 'PCWIN64'
        % Windows
        % Here we will look both into Windows default paths and the Xilinx
        % paths.
        [code, cmPATH] = system("echo %PATH%");
        [code, psPATH] = system("powershell $Env:Path");
        pathList = split(strcat(cmPATH, psPATH), ':');

        % Xilinx default paths
        possibleVersions = {2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023};
        possibleSubVersions = {1, 2};
        possibleSoftware = {"Vitis", "Vivado"};
        possibleSubPaths = {fullfile("gnu", "aarch32", "nt", "gcc-arm-none-eabi", "bin"), fullfile("gnuwin", "bin"), fullfile("bin")};
        possibleXilinxPaths = {"C:\Program Files\Xilinx"};
        if not(isempty(zSettings.customXilinxPath))
            possibleXilinxPaths{end+1} = zSettings.customXilinxPath;
            flip(possibleXilinxPaths);
        end
        [vi, svi, swi, spi, xpi] = ndgrid(1:numel(possibleVersions), ...
                                            1:numel(possibleSubVersions), ...
                                            1:numel(possibleSoftware), ...
                                            1:numel(possibleSubPaths), ...
                                            1:numel(possibleXilinxPaths));

         nPerms = numel(vi);
        possiblePerms = [reshape(possibleXilinxPaths(xpi(:)), [], 1), ...
                                reshape(possibleSoftware(swi(:)), [], 1), ...
                                  reshape(possibleVersions(vi(:)), [], 1), ...
                                  reshape(possibleSubVersions(svi(:)), [], 1), ...
                                  reshape(possibleSubPaths(spi(:)), [], 1)];
        % Xilinx Path -- Software -- Version.Subversion -- SubPath
        possibleXilinxPaths = arrayfun(@(x) fullfile(possiblePerms{x, 1}, ...
                                                    possiblePerms{x,2}, ...
                                                    sprintf("%i.%i", possiblePerms{x,3}, possiblePerms{x, 4}), ...
                                                    possiblePerms{x, 5}), ...
                                                    reshape(1:nPerms, [], 1));
        
        
        pathList = vertcat(possibleXilinxPaths, pathList);
        pathList = cellfun(@(x) char(x), pathList, 'UniformOutput',false);
        
        uniquePathList = {};
        for j=1:numel(pathList)
            pth = pathList{j};
            if find(strcmp(pth, pathList), 1) == j
                uniquePathList = vertcat(uniquePathList, pth);
            end
        end

        if false
            for j=1:numel(uniquePathList)
                fprintf("%s\n", uniquePathList{j});
            end
        end


    case 'GLNXA64'
        % Linux

end