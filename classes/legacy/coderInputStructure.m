classdef (HandleCompatible) coderInputStructure 
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Name = 'FULL_INPUT_STRUCTURE'
        Type = 'struct'
        SizeByes = NaN
        NumEl = 1
        TypeSize = NaN
        PaddedSize = NaN
        Dimension = 1
        Padding = 0
        Children = [];
        originalObject 
    end

    methods
        function obj = coderInputStructure(codeInfoObject)
            
            %UNTITLED4 Construct an instance of this class
            %   Detailed explanation goes here

            % Iterate over the Inports object
            numChildren = numel(codeInfoObject.Inports);
            for j=1:numChildren
                % Call the coderArgument static method processObject.
                % It will release a subclass of coderArgument with the
                % associated type
                output = coderArgumentFactory.processObject(codeInfoObject.Inports(j));
                
                % Append to Children object
                obj.Children = horzcat(obj.Children, output);
            end
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end