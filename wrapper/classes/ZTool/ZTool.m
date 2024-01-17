classdef ZTool < handle

    properties
        name = ""
        foldername = ""
        description = ""
    end

    properties (SetAccess = private, Hidden = false)
        % The ZToolManager that owns this tool
        supportsWin = false;
        supportsLinux = false;
        supportsMac = false;

        path = "";
        execpath = "";
    end

    properties (Access = private)
        fail = @error;
        project ZProject = ZProject.empty();
    end

    methods

        % ========================================================================
        % Constructor

        function obj = ZTool(project)
            obj.project = project;
        end

        % ========================================================================
        % Check interface - not to be overridden.
        function installed = check(obj, ask)
            if nargin == 1
                ask = true;
            end

            installed = obj.checkInstall();
            if ~installed && ask
                installed = obj.askInstall();
            end
        end 
        

        % ========================================================================
        % Install interactive interface - not to be overridden.
        function installed = askInstall(obj)
            fprintbf("Do you want to download and install %s locally? [Y/n]", obj.name);
            answer = input(">> ", 's');
            switch answer
                case {'Y', 'y', ''}
                    obj.install();
                    installed = obj.check();
                otherwise
                    obj.fail("%s needed to run zWrap.", obj.name); 
            end
                    
        end
                
        
        
        % ========================================================================
        % Install interface - must be implemented for all subclasses. 
        % This selector should NOT be overridden - instead, override the
        % OS implementations.
        function selectInstall(obj)
            % Check platform
            switch computer
                
                case 'MACA64';  obj.installMac();
                case 'GLNXA64'; obj.installLinux();
                case 'PCWIN64'; obj.installWin();
                otherwise;      error("Architecture not supported for install.")
            end
                
        end

        % ========================================================================
        % Check interface
        function checkInstall(obj)
            execFile = obj.execFile();


            % Attempt 1: Look for the tool in custom paths
            % Check if the tool has been assigned a custom path
            if obj.hasCustomPath()
                toolpath = fullfile(obj.getCustomPath(), execFile);
                if isfile(toolpath) 
                    tmp = what(toolpath); 
                    obj.path = tmp.path; obj.execpath = fullfile(obj.path, execFile);
                    fprintf("%s found at %s\n", obj.name, obj.execpath);
                    return;
                else
                    warning("Custom path for %s does not exist. Trying default paths.", obj.name);
                end
            end


            % Attempt 2: Look for the tool in local tool folder
            % Check if the tool is in the local tool folder
            localTool = fullfile("tools", obj.foldername, execFile);
            if isfile(localTool)
                tmp = what(localTool); 
                obj.path = tmp.path; obj.execpath = fullfile(obj.path, execFile);
                fprintf("%s found at %s\n", obj.name, obj.execpath);
                return;
            end


            % Attempt 3: Look for the tool in system paths
            % Check if the tool is in global paths
            uniquePathList = obj.getPossibleToolPaths();
            % Check for the execFile in all possible tool paths
            foundExec = cellfun(@(x) isfile(fullfile(x, execFile)), uniquePathList);
            if not(any(foundExec))
                obj.fail("%s not found. Please install from official sources. ", obj.name);
                obj.path = false;
                obj.execpath = false;
                return
            end            
            
            % Note: any other check should be done in the subclasses

        end
            
    end
    
    
    methods (Abstract)

        % ========================================================================
        % Name getter interface - must be implemented for all subclasses
        function execName = execFile()
            % Check platform
            switch computer
                case 'MACA64';  execName = "null";
                case 'GLNXA64'; execName = "null";
                case 'PCWIN64'; execName = "null.exe";
                otherwise;      error("Architecture not supported for execution.")
            end
        end
        
        % ========================================================================
        % Install interface - must be implemented for all subclasses
        function install()
            % Check platform
            switch computer
                case 'MACA64';  installMac();
                case 'GLNXA64'; installLinux();
                case 'PCWIN64'; installWin();
                otherwise;      error("Architecture not supported for execution.")
            end
        end

        % MacOS
        function installMac(obj)
            obj.fail("Installation procedure not implemented for %s on MacOS", obj.name);
        end
        
        % Linux
        function installLinux(obj)
            obj.fail("Installation procedure not implemented for %s on Linux", obj.name);
        end
        
        % Windows
        function installWin(obj)
            obj.fail("Installation procedure not implemented for %s on Windows", obj.name);
        end


    end

    % Utility methods - static methods to be called in subclasses
    methods (Static = true)

        % function bool = hasCustomPath(obj)
        % Check for custom path in the project settings.
        function bool = hasCustomPath(obj)
            bool = isfield(obj.project.settings.cp, 'customBootgenPath') && ...
                   isfile(fullfile(zSettings.customBootgenPath, obj.execFile()));
        end

        
        % ==============================================================
        % function customPath = getCustomPath(obj)
        % Get custom path from the project settings, if available
        function customPath = getCustomPath(obj)
            if obj.hasCustomPath()
                customPath = obj.project.settings.cp.(obj.name);
            else
                customPath = "";
            end
        end

        
        % function uniquePathList = getPossibleToolPaths() 
        % Get possible paths for the tool, depending on the platform
        function uniquePathList = getPossibleToolPaths() 
            switch computer
                case 'MACA64';  uniquePathList = obj.getPossibleToolPathsMac();
                case 'GLNXA64'; uniquePathList = obj.getPossibleToolPathsLinux();
                case 'PCWIN64'; uniquePathList = obj.getPossibleToolPathsWin();
                otherwise;      error("Architecture not supported for execution.")
            end
        end


        % function uniquePathList = getPossibleToolPathsMac()
        % MacOS implementation
        function uniquePathList = getPossibleToolPathsMac()
            % MacOS - we can look at the path variable as set by zsh. 
            % In order to do this, zsh should first load the .zprofile
            % and then we can echo the path
            
            % Echo the path set in .zprofile
            [~, zshPATH] = system("source ~/.zprofile && echo $PATH");

            % Split line by line
            pathList = split(zshPATH, ':');
        
            % Add default paths to list
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

            % Convert to char (?)
            % TODO: Check if this is needed
            pathList = cellfun(@(x) char(x), pathList, 'UniformOutput',false);
            
            % Remove duplicates
            uniquePathList = removeDuplicatePaths(pathList);
            
        end


        
        % function uniquePathList = getPossibleToolPathsWin()
        % Windows implementation
        function uniquePathList = getPossibleToolPathsWin()
            % Windows - Here we will look at Windows default paths

            [~, cmPATH] = system("echo %PATH%");
            [~, psPATH] = system("powershell $Env:Path");
            pathList = split(strcat(cmPATH, psPATH), ':');
            uniquePathList = removeDuplicatePaths(pathList);

            return

            % TODO: Move this into the Xilinx tool object
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
            

        end

        
        % function uniquePathList = getPossibleToolPathsLinux()
        % Linux implementation
        % TODO: Add linux implementation
        function uniquePathList = getPossibleToolPathsLinux()
            uniquePathList = {};
        end

        % ==============================================================
        % function uniquePathList = removeDuplicatePaths(pathList)
        % Removes duplicate paths in pathlists.
        function uniquePathList = removeDuplicatePaths(pathList)
            for j=1:numel(pathList)
                pth = pathList{j};
                if find(strcmp(pth, pathList), 1) == j
                    uniquePathList = vertcat(uniquePathList, pth);
                end
            end
        end
            
    end

end