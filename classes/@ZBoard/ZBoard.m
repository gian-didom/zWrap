classdef ZBoard < handle
    properties (Access = private)
        % Define properties here
        coderConfig                               % Coder configuration object to use for this board
        name                                      % Name of the board
        
    end
    
    properties
        % Define properties here
        extensions struct                         % Supported extensions
        tools struct                              % Needed tools
        project ZProject    = ZProject.empty()    % Associated project
    end
    
    methods
        % Define methods here

        function obj = ZBoard()
            % Class constructor
        end

        function addTool(obj, tool)
            obj.tools(1).(tool.name) = tool;
        end

        function addExtension(obj, extension)
            obj.extensions(1).(extension.name) = extension;
        end


        function setProject(obj, project)
            obj.project = project;
        end

        function build(obj)

            % Check tools
            for j = 1:length(obj.tools)
                obj.tools(j).check()
            end

        end

        function loadIOExtensions(obj)
            % I/O extension loading
            for extension = obj.project.settings.ext
                if isfield(obj.extensions, extension)
                    printf("Loading I/O extension %s...", extension)
                    obj.extensions.(extension).io();
                else
                    warning("No extension named %s exists.", extension)
                end
            end
        end

        function loadCodegenExtensions(obj)
            % I/O extension loading
            for extension = obj.project.settings.ext
                if isfield(obj.extensions, extension)
                    printf("Loading codegen extension %s...", extension)
                    obj.extensions.(extension).codegen();
                else
                    warning("No extension named %s exists.", extension)
                end
            end
        end

        
    end

    % Define additional class elements here
end
