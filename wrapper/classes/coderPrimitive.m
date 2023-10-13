classdef (HandleCompatible) coderPrimitive < coderArgument
    %UNTITLED10 Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods
        function obj = coderPrimitive(codeInfoObj)
            %UNTITLED10 c an instance of this class
            %   Detailed explanation goes here
            obj.Padding = 0;
            obj.Children = [];
            obj.ByteSize = ceil(double(codeInfoObj.WordLength)/8);
            if obj.ByteSize == 0
                keyboard
            end
            obj.Type = codeInfoObj.Identifier;
            obj.MATLABType = codeInfoObj.Name;
            obj.setMATLABCastType();
            obj.AlignmentRequirement = obj.ByteSize;
        end

        function outvar = getTemplate(obj)
            % This is a structure with certain fields. In order to get the
            % fields, we get the Children.
            outvar = cast(0, obj.MATLABType);
        end


        %%
        function bytesize = getTotalSize(obj)
            bytesize = obj.ByteSize;

        end

        %% 
        function name = getCppArgumentForCall(obj, baseName)
            switch obj.Role
                case 'output'
            name = strcat('&(', baseName, '->', obj.Name, ')');

                otherwise
            name = strcat(baseName, '->', obj.Name);
            end
            
        end

        %%
        function paddedSize = getTotalSizePadded(obj)
            paddedSize = obj.getTotalSize();
            obj.PaddedSize = paddedSize;
        end

        %% printTree(obj, indent)

        function printTree(obj, indent)
            printTree@coderArgument(obj, indent);

            fprintf('<strong>%s</strong> [%s] ', obj.Name, obj.MATLABName);
            fprintf('<%s (%s)>\n',obj.Type, obj.MATLABType);

        end

        %% getMappingFunction(obj)
        function [fcn, checkFcn] = getMappingFunction(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            fcn = @(x) typecast(cast(x,obj.MATLABType), 'uint8');

            % Check
            checkFcn = @(x) (numel(fcn(x)) == obj.Size);
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

        %% function MATLABScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateMATLABFunction(obj, accessName, ~)
            % The accessName is given from the parent
            functionScript = sprintf("byteArray(%i:%i) = typecast(cast(%s, '%s'), 'uint8');", ...
                obj.memoryOffset+1, obj.memoryOffset+obj.ByteSize, accessName, obj.MATLABCastType);
            
        end

        %% function functionScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateDecoderFunction(obj, accessName, ~)
            % The accessName is given from the parent

            functionScript = sprintf("%s = cast(typecast(uint8(byteArray(arrayPointer+%i:arrayPointer+%i)), '%s'), '%s');", ...
                accessName, 1, obj.ByteSize, obj.MATLABCastType, obj.MATLABType);

            % Increase arrayPointer;
            functionScript = vertcat(functionScript, ...
                sprintf("arrayPointer = arrayPointer + %i; arrayPointer = arrayPointer + %i;", ...
                obj.PaddedSize, obj.Padding));


        end
    end
end