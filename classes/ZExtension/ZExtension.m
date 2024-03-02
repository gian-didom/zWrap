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

        function io(obj)
            % Implementation of extension during I/O definition phase
        end

        function codegen(obj)
            % Implementation of extension during codegen phase
        end
    end

end