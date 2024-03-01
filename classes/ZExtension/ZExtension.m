classdef ZExtension

    properties
        board ZBoard;
    end

    methods
        function obj = ZExtension()

        end

        function io(obj)
            % Implementation of extension during I/O definition phase
        end

        function codegen(obj)
            % Implementation of extension during codegen phase
        end
    end

end