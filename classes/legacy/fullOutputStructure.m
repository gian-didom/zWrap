classdef (HandleCompatible) fullOutputStructure < coderNestedObject
    %UNTITLED11 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        
    end

    methods
        function obj = fullOutputStructure(codeInfoObject)
            %UNTITLED11 Construct an instance of this class
            %   Detailed explanation goes{ here
                    % We're at the top level - this is the top-level structure!
                    obj.Type = 'struct';
                    obj.ByteSize= NaN;         % Right now, not a number
                    obj.Name = 'FULL_OUTPUT_STRUCTURE';
                    obj.Padding = 0;
                    obj.Children = [];
                    for j=1:numel(codeInfoObject.Outports)
                        output = coderArgumentFactory.processObject(codeInfoObject.Outports(j));
                        obj.Children = appendCell(obj.Children, output);
                    end
        end



        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end