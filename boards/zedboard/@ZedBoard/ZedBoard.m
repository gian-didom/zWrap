classdef ZedBoard < ZBoard
    % Your class implementation goes here
    properties
        % Your class properties go here
        name = "ZedBoard";
    end

    methods
        function obj = ZedBoard()
            % Constructor
            obj = obj@ZBoard();

            % Name
            obj.name = "ZedBoard";

            % Tools
            obj.tools.make = ZGNUMake();        % GNU make
            obj.tools.armtools = ZARMTools();   % Arm tools
            obj.tools.bootgen = ZBootgen();     % Bootgen
            
            % Extensions
            obj.extensions.timing = timingExtension(obj);

            % Coder configuration
            % TODO: Add coder configuration (load or write)
            
        end
    end
    
end
