classdef ZedBoard < ZBoard
    % Your class implementation goes here
    properties
        % Your class properties go here
    end

    methods
        function obj = ZedBoard()
            % Constructor
            obj = obj@ZBoard();

            % Name
            obj.name = "ZedBoard";

            % Tools
            obj.tools.make = ZGnuMake();        % GNU make
            obj.tools.armtools = ZArmTools();   % Arm tools
            obj.tools.bootgen = ZBootgen();     % Bootgen
            
            % Extensions
            obj.extensions.timing = timingExtension(obj);

            % Coder configuration
            % TODO: Add coder configuration (load or write)
            
        end

        % function CppScript = generateMemoryMap(obj, save_file_path)
        %     % Generate memory map

        % function generateCEntryPoint(obj)
        %     % Generate C entry point

            % function CppScript = generateCppCallHeader(obj, save_file_path)
            %     % Generate C++ call header

            % function CppScript = generateCppCallSource(obj, save_file_path)
            %     % Generate C++ call source

        function build(obj) 

            % I/O extension
            obj.loadIOExtensions();

            % Build
            obj.generateMemoryMap();
            obj.generateCEntryPoint();

            % Run codegen extensions
            obj.loadCodegenExtensions();

        end
        



    end
end
