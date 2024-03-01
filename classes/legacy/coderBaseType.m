classdef (HandleCompatible) coderBaseType < coderArgument
    %UNTITLED10 Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods
        function obj = coderBaseType(codeInfoObj)
            %UNTITLED10 c an instance of this class
            %   Detailed explanation goes here
            obj.Padding = 0;
            obj.Children = {};
            obj.Name = codeInfoObj.Identifier;
            obj.Type = codeInfoObj.Type.Identifier;
            obj.Dimension = 1;
            obj.ByteSize= obj.Dimension * codeInfoObj.Type.WordLength/8;
            obj.Type = codeInfoObj.Type.Identifier;
            obj.MATLABType = codeInfoObj.Type.Name;
            obj.isDataType = true;
            obj.MATLABName = obj.Name;
            obj.AlignmentRequirement = obj.ByteSize;
        end

        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end

        function [fcn, checkFcn] = getMappingFunction(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            fcn = @(x) typecast(cast(x,obj.MATLABType), 'uint8');

            % Check
            checkFcn = @(x) (numel(fcn(x)) == obj.Size);
        end


        function size = getTotalSize(obj)
            size = obj.ByteSize;
        end

        function dataRepr = mappingFunction(obj, inputVariable)
            dataRepr = typecast(cast(inputVariable(:),obj.MATLABType), 'uint8');
            if numel(dataRepr) < obj.Size
                % We must add zeros because the matrix is smaller
                error("We should not be here");
            end
            %% TODO: Add special case for logical
        end

        % Checks for data representation size
        function isGood = checkFunction(obj, dataRepr)
            isGood = numel(dataRepr) <= obj.Size;

        end


        function outputVariable = buildingFunction(obj, inputStream)
            assert(numel(inputStream) >= obj.Size, "The stream should be bigger than the object size.");
           
            castedArray = typecast(inputStream(1:obj.Size), obj.MATLABType);
            if size(obj.Dimension) > 1
            outputVariable = reshape(castedArray, obj.Dimension);
            else
            outputVariable= castedArray;
            end
        end
    end
end