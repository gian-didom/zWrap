classdef ZProject < handle
    %ZProject Summary of this class goes here
    %   Detailed explanation goes here

    properties
        settings (1,1)  zWrapSettings;
        packDir                                 = "";
        inputs          fullInterfaceStructure  = fullInterfaceStructure.empty();
        outputs         fullInterfaceStructure  = fullInterfaceStructure.empty();
    end

    properties (Access = private)
        buildInfoStruct;
        codeInfoStruct;
        compileInfoStruct;
        buildInfo;
        codeInfo;
        targetFolder;
        board zBoard                            = zBoard.empty();
    end

    methods

        % =================================================================
        % =================================================================
        % ZProject(args)

        function obj = ZProject(args)
            %ZProject Construct an instance of this class
            %   Detailed explanation goes here
            if isstring(args)
                obj.settings = zWrapSettings(args);
            elseif isstruct(args)
                obj.settings = zWrapSettings();
                for f=fields(args)
                    obj.settings.(f) = args.(f);
                end
            end
        end


        % =================================================================
        % =================================================================
        % load(obj) - Loads the buildInfo, codeInfo and compileInfo
        % objects found in the set project path.

        function obj = load(obj)
            % load(obj) - Loads the buildInfo, codeInfo and compileInfo
            % objects found in the set project path.

            fprintbf('Loading coded project information...');

            obj.buildInfoStruct = load(fullfile(coder_project_path, 'buildInfo.mat'));
            obj.codeInfoStruct = load(fullfile(coder_project_path, 'codeInfo.mat'), 'codeInfo');
            obj.compileInfoStruct = load(fullfile(coder_project_path, 'compileInfo.mat'));


            obj.buildInfo = obj.buildInfoStruct.buildInfo;
            obj.codeInfo = obj.codeInfoStruct.codeInfo;
            
            obj.printDone();

        end

        % =================================================================
        % =================================================================
        % pack(obj) - Create packNGo including all headers

        function packDir = pack(obj)
            % pack - Create packNGo including all headers
            if not(obj.settings.pack)
                fprintbf('Packing code including all headers... ');
                zipName = fullfile(coder_project_path, ...
                    strcat(obj.buildInfo.ComponentName, ".zip"));
                packDir = fullfile(coder_project_path, 'pack');

                if (exist(obj.packDir, 'dir'))
                    rmdir(obj.packDir, 's');
                end
                modifiedpackNGo(fullfile(coder_project_path, 'buildInfo.mat'), ...
                    'minimalHeaders', false, ...
                    'fileName', zipName);
                unzip(zipName, obj.packDir);
                fprintbf('All code succesfully packed in %s', obj.packDir);
                printDone();
            else
                packDir = coder_project_path;
            end

            obj.packDir = packDir;
        end

        % =================================================================
        % =================================================================
        % commentMains(obj) - Comment out main functions

        function commentMains(obj)
            % commentMains(obj) - Comment out main functions
            if isfile(fullfile(obj.packDir, 'ert_main.c'))
                movefile(fullfile(obj.packDir, 'ert_main.c'), fullfile(obj.packDir, 'ert_main.cbak'));
            end

            if isfile(fullfile(obj.packDir, 'ert_main.h'))
                movefile(fullfile(obj.packDir, 'ert_main.h'), fullfile(obj.packDir, 'ert_main.hbak'));
            end
        end

        % =================================================================
        % =================================================================
        % processInput(obj) - process inputs

        function processInput(obj)
            obj.inputs = fullInterfaceStructure(obj.codeInfo, 'input');
            obj.inputs.getTotalSize();
            obj.inputs.getTotalSizePadded();
            obj.inputs.printTree();
            fprintf('\n\n\n');
        end


        % =================================================================
        % =================================================================
        % processOutput(obj) - process outputs

        function processOutput(obj)
            obj.outputs = fullInterfaceStructure(obj.codeInfo, 'output');
            obj.outputs.getTotalSize();
            obj.outputs.getTotalSizePadded();
            obj.outputs.printTree();
            fprintf('\n\n\n');
        end


        % =================================================================
        % =================================================================
        % generateProjectFolder(obj) - Creates the project folder

        function generateProjectFolder(obj) 
            fprintbf('Generating project folder...\n');
            targetFolderName = fullfile('out', sprintf("z%s", obj.inputs.fcnName));
            
            
            % 1. Create project folder
            if exist(targetFolderName, 'dir')
                if obj.settings.y
                    usrInput = 'y';
                else
                    usrInput = input(sprintf("<strong>Folder %s already exists, overwrite?</strong> [Y/n/k] [k]\n", ...
                        targetFolderName), "s");
                end
            
            
                switch usrInput
            
                    case {'Y', 'y'}
                        warning('off', 'MATLAB:rmpath:DirNotFound');
                        rmpath(genpath(targetFolderName))
                        rmdir(targetFolderName, 's')
                        warning('on', 'MATLAB:rmpath:DirNotFound');
            
                    case {'K', 'k', ''}
                        new_targetFolderName = targetFolderName;
                        j=1;
                        while exist(new_targetFolderName, "dir")
                            new_targetFolderName = sprintf("%s%i", targetFolderName, j);
                            j = j+1;
                        end
                        targetFolderName = new_targetFolderName;
            
                    otherwise
                        fprintf("Aborting.");
                        return
                end

                
            end
            
            mkdir(targetFolderName);
            mkdir(fullfile(targetFolderName, "generated"));
            mkdir(fullfile(targetFolderName, "simulink"));
            mkdir(fullfile(targetFolderName, "project"));
            
            addpath(genpath(targetFolderName));
            fprintbf("Project folder generated at %s\n", targetFolderName);
            
            obj.targetFolder = targetFolderName;
            
        end
        
        % =================================================================
        % =================================================================
        % generateInputStreamParser(obj) - Generates the iniput stream
        % parser function

        function generateInputStreamParser(obj)
            fprintbf('Generating input stream encoding and test function...');
            obj.inputs.generateMATLABFunction(fullfile(obj.targetFolder, 'simulink'));
            obj.inputs.generateDecoderFunction(fullfile(obj.targetFolder, 'simulink'), true);
            printDone();
        end

        % =================================================================
        % =================================================================
        % generateOutputStreamParser(obj) - Generates the output stream
        % decoding function

        function generateOutputStreamParser(obj)
            fprintbf('Generating output stream decoding and test function...');
            obj.outputs.generateDecoderFunction(fullfile(obj.targetFolder, 'simulink'));
            obj.outputs.generateMATLABFunction(fullfile(obj.targetFolder, 'simulink'), true);
            printDone();
        end

        % =================================================================
        % =================================================================
        % generateSimulinkBlock(obj) - Generates the Simulink block 

        function generateSimulinkBlock(obj)
            %% GENERATE INTERFACES
            if (obj.settings.nosimulink)
                fprintbf("Skipping Simulink generation...\n");
            else
            fprintbf('Generating Simulink library...')
            SimulinkLibraryPath = fullfile(obj.targetFolder, 'simulink', sprintf('%s.slx', obj.inputs.fcnName));
            % TODO: Use a ZSimulinkGenerator object!
            generateSimulinkLibrary(obj.inputs, obj.outputs, SimulinkLibraryPath);
            printDone();
            fprintbf('\nSimulink library succesfully created at %s!\n', SimulinkLibraryPath)
            end
        end

        % =================================================================
        % =================================================================
        % build(obj) - Builds the project

        function build(obj) 
            %% BUILD THE PROJECT running the toolchain associated to the board.
            fprintbf('Building project...\n');
            try 
                obj.board.build();
            catch ME
                fprintbf('Error building project: %s\n', ME.message);
                return
            end
            printDone();
            
        end
        
    end

    methods (Static = true)
        % =================================================================
        % =================================================================

        function printDone()
            fprintbf('\t✓ Done.\n');
        end
    end

end

