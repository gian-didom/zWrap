classdef ZExtension
    
    properties
        board ZBoard;
    end
    
    properties (Access = private)
        name
    end
    
    methods
        function obj = ZExtension(board)
            obj.board = board;
        end
    end
    
    methods(Abstract)
        % Implementation of extension during codegen phase
        io(obj);
        codegen(obj);
    end
end
