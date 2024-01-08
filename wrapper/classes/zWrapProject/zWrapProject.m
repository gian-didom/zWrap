classdef zWrapProject < handle
    %ZWRAPPROJECT Summary of this class goes here
    %   Detailed explanation goes here

    properties
        settings (1,1) zWrapSettings;
        packDir = "";
        inputs fullInterfaceStructure = fullInterfaceStructure.empty();
        outputs fullInterfaceStructure = fullInterfaceStructure.empty();


    end

    properties (Access = private)
        buildInfoStruct;
        codeInfoStruct;
        compileInfoStruct;
        buildInfo;
        codeInfo;
    end

    methods

        % =================================================================
        % =================================================================

        function obj = zWrapProject(args)
            %ZWRAPPROJECT Construct an instance of this class
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
        %pack - Create packNGo including all headers

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


    end

    methods (Static = true)
        % =================================================================
        % =================================================================

        function printDone()
            fprintbf('\t✓ Done.\n');
        end
    end

end

