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
            obj.addTool(ZGNUMake());        % GNU make
            obj.addTool(ZARMTools());       % ARM tools
            obj.addTool(ZBootgen());        % Bootgen
            
            % Extensions
            obj.addExtension(timingExtension(obj));

            % Coder configuration
            % TODO: Add coder configuration (load or write)
            
        end
    end
    
end
