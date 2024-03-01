function pathList = getSystemLibPaths()
global zSettings



switch computer
    case 'MACA64'
        % MacOS
        % Since typically bootgen is not found in the typical paths, we can
        % look at the path variable as set by zsh. In order to do this, zsh
        % should first load the .zprofile and then we can echo the path
        
    
        pathList = { ...
            "/opt/homebrew/lib";
            "/usr/local/lib";
            "/usr/lib";
            "/lib";
            "/Library/Apple/usr/lib";
            };

        pathList = cellfun(@(x) char(x), pathList, 'UniformOutput',false);

    case 'PCWIN64'
        % Windows
        % Here we will look both into Windows default paths and the Xilinx
        % paths.
        

    case 'GLNXA64'
        % Linux

end