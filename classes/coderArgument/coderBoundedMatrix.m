classdef (HandleCompatible, Abstract) coderBoundedMatrix < coderMatrix
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        SizeType
        DataTypePadding

    end

    methods

        %% function obj = coderBoundedMatrix(dataObj, sizeObj)
        function obj = coderBoundedMatrix(dataObj, sizeObj)
            obj@coderMatrix(dataObj);
            % All bounded matrices have a dataObj and a sizeObj.
            % obj.Name = codeInfoObj.Identifier;
            obj.DataType = coderArgument.processObject(dataObj.Type);
            obj.SizeType = coderArgument.processObject(sizeObj.Type);

            obj.BaseType = obj.DataType.BaseType;
            obj.Type = obj.BaseType.Type;
            
            if strcmp(obj.BaseType.MATLABType, 'cell')
                obj.isCell = true;
            end

            % Get matrix dimensions
            obj.Dimension = dataObj.Type.Dimensions;
            % Get total number of elements
            obj.NumEl = prod(obj.Dimension);

            obj.setMATLABCastType();

        end

        %% function outvar = getTemplate(obj)

        function outvar = getTemplate(obj)
            % This is a structure with certain fields. In order to get the
            % fields, we get the Children.
            if isa(obj.BaseType, "coderPrimitive")
                outvar = cast(zeros(obj.Dimension), obj.DataType.BaseType.MATLABType);
            else
                for j=1:obj.NumEl
                    outvar(j) = obj.DataType.BaseType.getTemplate();
                end
                if numel(obj.Dimension) == 1
                    outvar = reshape(outvar, 1, []);
                else
                    outvar = reshape(outvar, obj.Dimension);
                end
            end
        end

        %% function bytesize = getTotalSize(obj)
        function bytesize = getTotalSize(obj)
            dataSize = obj.DataType.getTotalSize();
            sizeSize = obj.SizeType.getTotalSize();
            bytesize = dataSize + sizeSize;
            obj.ByteSize = bytesize;
        end

        %% function paddedSize = getTotalSizePadded(obj)
        function paddedSize = getTotalSizePadded(obj)

            obj.DataType.memoryOffset = obj.memoryOffset;
            obj.DataType.Padding = -mod(obj.DataType.getTotalSizePadded(), -obj.SizeType.AlignmentRequirement);

            obj.SizeType.memoryOffset = obj.memoryOffset + obj.DataType.getTotalSizePadded() + obj.DataType.Padding;
            paddedSize = obj.DataType.getTotalSizePadded() + ...
                obj.DataType.Padding + ...
                obj.SizeType.getTotalSizePadded();
            obj.PaddedSize = paddedSize;
        end


        %% function [fcn, checkFcn] = getMappingFunction(obj)
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

        %% function dataRepr = mappingFunction(obj, inputVariable)
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
            % TODO: Add special case for logical
        end

        %% function isGood = checkFunction(obj, dataRepr)
        % Checks for data representation size
        function isGood = checkFunction(obj, dataRepr)
            isGood = numel(dataRepr) <= obj.Size;
        end


        %% function outputVariable = buildingFunction(obj, inputStream, varargin)
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

                typeSize = obj.SizeBytes/ obj.NumEl;
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


        %% function MATLABScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateMATLABFunction(obj, accessName, nestLevel)
            % The accessName is given from the parent
            if nargin == 2; nestLevel = 1; end

            arrayName = strcat(generateRandomString(), '_vmat');
            % Initialize array
            functionScript = {sprintf("\n%s = uint8(zeros(%i, 1));", arrayName, obj.PaddedSize)};

            if isa(obj.DataType.BaseType, "coderPrimitive")
                % We can typecast directly
                functionScript = vertcat(functionScript, ...
                    sprintf("%s(%i:%i+numel(%s)*%i) = typecast(cast(%s(:), '%s'), 'uint8');", ...
                    arrayName, 1, 0,accessName, obj.DataType.BaseType.ByteSize, ...
                    accessName, obj.DataType.BaseType.MATLABCastType));


                functionScript = vertcat(functionScript, ...
                    sprintf("%s_size = ones(1,%i);", arrayName, obj.SizeType.Dimension));

                functionScript = vertcat(functionScript, ...
                    sprintf("%s_size(1:numel(size(%s))) = size(%s).';", ...
                    arrayName, accessName, accessName));

                
                functionScript = vertcat(functionScript, ...
                    sprintf("%s(%i:%i) = typecast(cast(%s_size, '%s'), 'uint8');", ...
                    arrayName, ...
                    obj.DataType.PaddedSize+1+obj.DataType.Padding, ...
                    obj.DataType.PaddedSize+obj.DataType.Padding+obj.SizeType.PaddedSize, ...
                    arrayName, obj.SizeType.BaseType.MATLABCastType));

                functionScript = vertcat(functionScript, ...
                    sprintf("byteArray(%i:%i) = %s;\n", ...
                    obj.DataType.memoryOffset+1, ...
                    obj.DataType.memoryOffset+obj.PaddedSize, arrayName));

            else
                % We need to instantiate a for-loop

                indexLoop = repmat('j', 1, nestLevel);

                % Now we must fill the first part (obj.DataType.PaddedSize)
                % with the data coming from each BaseType object.
                % To do this, we must iterate over the indexes.
                % This matrix is fixed BUT it doesn't mean anything since
                % fixed matrices are also inside variable matrices - bof...
                functionScript = vertcat(functionScript, ...
                    sprintf("for %s=1:numel(%s)", indexLoop, accessName));

                % Generate lines for Base Type
                outlines = obj.DataType.BaseType.generateMATLABFunction( ...
                    sprintf("%s(%s)", accessName, indexLoop), nestLevel+1 ...
                    );

                % Replace all the byteArray assignments with the
                % assignments on the localArray. Then, we will index the
                % localArray into the ByteArray. This is good to avoid
                % issue with memory indexes
                for j=1:numel(outlines)
                    sides = split(outlines(j), ' = ');
                    if numel(sides) > numel(outlines(j)) && startsWith(sides{1}, 'byteArray')
                        rhs = sides{2};
                        rhs_uncomm = split(rhs, ';');
                        outlines(j) = sprintf("%s((%s-1)*%i+1:%s*%i) = %s; %s", ...
                            arrayName, indexLoop, obj.DataType.BaseType.PaddedSize, ...
                            indexLoop, obj.DataType.BaseType.PaddedSize, ...
                            rhs_uncomm{1}, rhs_uncomm{2});
                    end
                    outlines(j) = strcat(sprintf("\t"), outlines(j));
                    % There is no data padding between array elements.
                    functionScript = vertcat(functionScript, outlines(j));

                end
                functionScript = vertcat(functionScript, sprintf("end"));




                functionScript = vertcat(functionScript, ...
                    sprintf("%s_size = ones(1,%i);", ...
                    arrayName, obj.SizeType.Dimension));

                functionScript = vertcat(functionScript, ...
                    sprintf("%s_size(1:numel(size(%s))) = size(%s).';", ...
                    arrayName, accessName, accessName));


                functionScript = vertcat(functionScript, ...
                    sprintf("%s(%i:%i) = typecast(cast(%s_size, '%s'), 'uint8');", ...
                    arrayName, obj.DataType.PaddedSize+1, obj.DataType.PaddedSize+obj.SizeType.ByteSize, ...
                    arrayName, obj.SizeType.BaseType.MATLABCastType));


                functionScript = vertcat(functionScript, sprintf("byteArray(%i:%i+numel(%s)) = %s; %%%i\n", ...
                    obj.memoryOffset+1, obj.memoryOffset, arrayName, arrayName, obj.memoryOffset+obj.ByteSize));


            end

        end


        %% function functionScript = generateDecoderFunction(obj, accessName)
        function functionScript = generateDecoderFunction(obj, accessName, nestLevel)

            arrayName = strcat(generateRandomString(), '_mat');
            % Initialize array

            % Generate local bytearray. Allocate its size based on the
            % DataType and SizeType
            functionScript = {};

            % input guard
            if nargin == 2; nestLevel = 1; end
            % The accessName is given from the parent

            % Get size for reshaping
            functionScript = vertcat(functionScript, ...
                sprintf("%s_size = reshape(typecast(byteArray(arrayPointer + %i+1:arrayPointer+%i+%i), '%s'), 1, []);", ...
                arrayName, ...
                obj.DataType.PaddedSize +obj.DataType.Padding, ...
                obj.DataType.PaddedSize +obj.DataType.Padding, ...
                obj.SizeType.PaddedSize, ...
                obj.SizeType.BaseType.MATLABCastType));

            % Initialize empty object
            % functionScript = vertcat(functionScript, ...
            % sprintf("%s = %s.empty(prod(%s_size), 0);", ...
            % arrayName, obj.BaseType.MATLABCastType, arrayName));


            % In this case, we only need to typecast the entire matrix. No
            % need for the size.
            if isa(obj.BaseType, "coderPrimitive")
                % We can typecast directly.


                % Cast byteArray into local array.
                functionScript = vertcat(functionScript, ...
                    sprintf("%s = cast(typecast(byteArray(arrayPointer+1:arrayPointer+%i*prod(%s_size)), '%s'),'%s');", ...
                    arrayName, ...
                    obj.DataType.BaseType.PaddedSize, ...
                    arrayName, ...
                    obj.BaseType.MATLABCastType, ...
                    obj.BaseType.MATLABType));

                % Increase arrayPointer;
                functionScript = vertcat(functionScript, ...
                    sprintf("arrayPointer = arrayPointer + %i;", ...
                    obj.PaddedSize));



            else
                % We need to instantiate a for-loop
                indexLoop = repmat('j', 1, nestLevel);

                % We need to access only the elements that have been
                % actually given.
                functionScript = vertcat(functionScript, ...
                    sprintf("for %s=1:%i %% Variable size", indexLoop, obj.NumEl));

                % Generate lines for Base Type.
                % The increase of the arrayPointer is managed internally.
                childAccessName = generateRandomString();
                outlines = obj.BaseType.generateDecoderFunction( ...
                    childAccessName,  nestLevel+1);
                functionScript = vertcat(functionScript, outlines);

                functionScript = vertcat(functionScript, ...
                    sprintf("if %s <= prod(%s_size)", indexLoop, arrayName), ...
                    sprintf("%s(%s) = %s;", ...
                    arrayName, indexLoop, childAccessName), ...
                    sprintf("end"));

                functionScript = vertcat(functionScript, sprintf("end"));

                            % Increase arrayPointer for Size;
            functionScript = vertcat(functionScript, ...
                sprintf("arrayPointer = arrayPointer + %i; %% Size", ...
                obj.SizeType.PaddedSize));

            end

            % Reshape and assign
            if obj.SizeType.Dimension>1
                functionScript = vertcat(functionScript, ...
                    sprintf("%s = reshape(%s(1:prod(%s_size)), %s_size);", ...
                    accessName, arrayName, arrayName, arrayName));
            else
                functionScript = vertcat(functionScript, ...
                    strcat(sprintf("%s = reshape(%s, 1, []);", accessName, arrayName)));
            end

            % Increase arrayPointer;
            functionScript = vertcat(functionScript, ...
                sprintf("arrayPointer = arrayPointer + %i; %% Padding", ...
                obj.Padding));





        end

    end
    methods(Static)

    end
end