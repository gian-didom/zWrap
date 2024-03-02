classdef (HandleCompatible) coderMatrix < coderArgument
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        DataType
        Dimension
        NumEl
        BaseType
    end

    methods (Abstract)
        %% methods(Abstract = true) -------------------------------------------------------
        %% function generateMATLABFunction(obj, accessName) ===============================
        generateMATLABFunction(obj, accessName);
        %% ================================================================================

    end

    methods
        function obj = coderMatrix(typeObj)
            obj@coderArgument(typeObj);


        end

%%
        function td = getCppDeclaration(obj)
            
            td = sprintf("%s %s[%i];", obj.BaseType.Type, obj.Name, obj.NumEl);

        end



%%
        function printTree(obj, indent)
            printTree@coderArgument(obj, indent);


            fprintf(bopen() + '%s' + bclose() + '[%s] ', obj.Name, obj.MATLABName);
            fprintf('<%s[%i]> (',obj.BaseType.Type, obj.NumEl);
            for j=1:numel(obj.Dimension)-1
                fprintf('%ix', obj.Dimension(j));
            end

            fprintf('%i %s)\n',  obj.Dimension(end), obj.BaseType.MATLABType)

            obj.BaseType.printTree(indent+1);

        end




        function [fcn, checkFcn] = getMappingFunction(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if (obj.hasSizeArray && not(obj.isSizeArray))
                fcn = @(x) mappingFunction(obj, x);
                return;
            end

            if (obj.isSizeArray && not(obj.hasSizeArray))
                fcn = @(x) typecast(cast(size(x), 'int32'), obj.Type);
            end

            % Check
            checkFcn = @(x) (numel(fcn(x)) == obj.Size);
        end

        % Mapping function
        function dataRepr = mappingFunction(obj, inputVariable)
            if (obj.hasSizeArray && not(obj.isSizeArray))

                % ******* PADDING - IS NOT NEEDED MOST PROBABLY *********
                % This is such a nasty trick :emoji laughing:
                % I_AM_NASTY = true;
                % if AM_I_NASTY
                %     eval(strcat("inputVariable[", strjoin(arrayfun(@(x) num2str(x), obj.Dimension, 'UniformOutput', false), ','), '] = 0;'));
                % else % I_AM_BORING
                %     % Ehhhhh now you need the Image Processing Toolbox.
                %     inputSize = size(inputVariable);
                %     inputSizePadded = obj.Dimensions.^0;
                %     inputSizePadded(1:numel(inputSize)) = inputSize;
                %     inputVariable = padarray(inputVariable, obj.Dimensions - inputSizePadded, 'post');
                % end
                % Now you can go on...

                dataRepr = typecast(cast(inputVariable(:),obj.MATLABType), 'uint8');
                if numel(dataRepr) < obj.Size
                    % We must add zeros because the matrix is smaller
                    dataRepr(obj.Size) = 0;
                end
            elseif (obj.isSizeArray && not(obj.hasSizeArray))
                dataRepr = typecast(cast(size(inputVariable), 'int32'), 'uint8');
            else
                dataRepr = typecast(cast(inputVariable(:), obj.MATLABType), 'uint8');
            end
            %% TODO: Add special case for logical
        end

        % Checks for data representation size
        function isGood = checkFunction(obj, dataRepr)
            isGood = numel(dataRepr) <= obj.Size;
        end


        function outputVariable = buildingFunction(obj, inputStream, varargin)




            if (obj.hasSizeArray && not(obj.isSizeArray))
                if numel(varargin)<1 || not(varargin{1}.isSizeArray)
                    error("This building needs to have the size object");

                end
                sizeArray = varargin{1};
                streamPointer = 1;

                % Is data array - should cast.
                % Then we must find the size
                sizeStreamPointer = streamPointer + obj.PaddedSize;
                arraySize = typecast(inputStream(sizeStreamPointer:sizeArray.Size+sizeStreamPointer-1), sizeArray.MATLABType);
                arraySize = reshape(arraySize, 1, []);

                typeSize = obj.ByteSize/ obj.NumEl;
                endPointerLocation = prod(arraySize)*typeSize;
                arrayData = typecast(inputStream(1:endPointerLocation), obj.MATLABType);
                outputVariable = reshape(arrayData, arraySize);


            elseif (obj.isSizeArray && not(obj.hasSizeArray))
                % Is size array - ignore.
                error("We should not be here.");
            else

                castedArray = typecast(inputStream(1:obj.Size), obj.MATLABType);
                outputVariable = reshape(castedArray, obj.Dimension);
            end
        end



    end
end