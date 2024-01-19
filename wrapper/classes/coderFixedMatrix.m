classdef (HandleCompatible) coderFixedMatrix < coderMatrix
    %UNTITLED8 Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods
        %%        function obj = coderFixedMatrix(codeInfoObj)

        function obj = coderFixedMatrix(codeInfoObj)
            obj@coderMatrix(codeInfoObj);
            obj.Name = codeInfoObj.Identifier;


            %UNTITLED8 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Dimension = codeInfoObj.Dimensions;
            obj.NumEl = prod(obj.Dimension);
            obj.BaseType = coderArgument.processObject2(codeInfoObj.BaseType);
            obj.Type = obj.BaseType.Type;

            if strcmp(obj.BaseType.MATLABType, 'cell')
                obj.isCell = true;
            end

            obj.AlignmentRequirement = obj.BaseType.AlignmentRequirement;
            obj.setMATLABCastType();
        end


        %%         function outvar = getTemplate(obj)

        function outvar = getTemplate(obj)
            % This is a structure with certain fields. In order to get the
            % fields, we get the Children.
            if isa(obj.BaseType, "coderPrimitive")
                outvar = cast(zeros(obj.NumEl, 1), obj.BaseType.MATLABType);
            else
                for j=1:obj.NumEl
                    outvar(j) = obj.BaseType.getTemplate();
                end
            end

            if numel(obj.Dimension) > 1
                outvar = reshape(outvar, obj.Dimension);
            else
                outvar = reshape(outvar, 1, []);
            end
        end



        %%        function td = getCppDeclaration(obj)

        function td = getCppDeclaration(obj)
            switch obj.Coder

                case 'MATLAB'
                    td = strcat(sprintf("%s %s", obj.BaseType.Type, obj.Name), ...
                        sprintf("[%i]", flip(obj.Dimension)), ...
                        ";");
                case 'Simulink'
                    td = strcat(sprintf("%s %s", obj.BaseType.Type, obj.Name), ...
                        sprintf("[%i]", prod(obj.Dimension)), ...
                        ";");
            end

        end

        %%         function size = getTotalSize(obj)

        function size = getTotalSize(obj)
            dataSize = obj.BaseType.getTotalSizePadded();
            size = dataSize * obj.NumEl;
            obj.ByteSize = size;
        end

        %%         function paddedSize = getTotalSizePadded(obj)

        function paddedSize = getTotalSizePadded(obj)
            obj.BaseType.getTotalSizePadded();
            paddedSize = obj.getTotalSize();
            obj.PaddedSize = paddedSize;
        end



        %%         function [fcn, checkFcn] = getMappingFunction(obj)

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

        %% function MATLABScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateMATLABFunction(obj, accessName, nestLevel)

            arrayName = strcat(generateRandomString(), '_mat');
            % Initialize array

            % Generate local bytearray. Allocate its size based on the
            % DataType and SizeType
            functionScript = {};
            functionScript = vertcat(functionScript, sprintf("\n%s = uint8(zeros(%i, 1));", arrayName, obj.PaddedSize));

            % input guard
            if nargin == 2; nestLevel = 1; end
            % The accessName is given from the parent

            % In this case, we only need too typecast the entire matrix. No
            % need for the size.
            if isa(obj.BaseType, "coderPrimitive")
                % We can typecast directly

                functionScript = vertcat(functionScript, ...
                    sprintf("%s(%i:%i) = typecast(cast(%s(:), '%s'), 'uint8');", ...
                    arrayName, 1, obj.ByteSize, ...
                    accessName, obj.BaseType.MATLABCastType));

                functionScript = vertcat(functionScript, ...
                    sprintf("byteArray(%i:%i) = %s;\n", ...
                    obj.memoryOffset+1, obj.memoryOffset+obj.PaddedSize, arrayName));

            else
                % We need to instantiate a for-loop
                functionScript = {};
                indexLoop = repmat('j', 1, nestLevel);

                functionScript = vertcat(functionScript, ...
                    sprintf('%s = uint8(zeros(1, %i));', arrayName, obj.PaddedSize));


                % Now we must fill the first part (obj.DataType.PaddedSize)
                % with the data coming from each BaseType object.
                % To do this, we must iterate over the indexes.
                % This matrix is fixed BUT it doesn't mean anything since
                % fixed matrices are also inside variable matrices - bof...
                functionScript = vertcat(functionScript, ...
                    sprintf("for %s=1:numel(%s)", indexLoop, accessName));

                % Generate lines for Base Type
                outlines = obj.BaseType.generateMATLABFunction( ...
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
                            arrayName, indexLoop, obj.BaseType.PaddedSize, ...
                            indexLoop, obj.BaseType.PaddedSize, ...
                            rhs_uncomm{1}, rhs_uncomm{2});
                    end
                    outlines(j) = strcat(sprintf("\t"), outlines(j));
                    % There is no data padding between array elements.
                    functionScript = vertcat(functionScript, outlines(j));

                end
                functionScript = vertcat(functionScript, sprintf("end"));

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

            % In this case, we only need too typecast the entire matrix. No
            % need for the size.
            if isa(obj.BaseType, "coderPrimitive")
                % We can typecast directly.
                % Cast byteArray into local array.
                functionScript = vertcat(functionScript, ...
                    sprintf("%s = cast(typecast(byteArray(arrayPointer+1:arrayPointer+%i), '%s'), '%s');", ...
                    arrayName, ...
                    obj.NumEl*obj.BaseType.PaddedSize, ...
                    obj.BaseType.MATLABCastType, ...
                    obj.BaseType.MATLABType));

                % Increase arrayPointer;
                functionScript = vertcat(functionScript, ...
                    sprintf("arrayPointer = arrayPointer + %i;", ...
                    obj.PaddedSize));

            else
                % We need to instantiate a for-loop
                functionScript = {};
                indexLoop = repmat('j', 1, nestLevel);
                functionScript = vertcat(functionScript, ...
                    sprintf("for %s=1:%i", indexLoop, obj.NumEl));

                % Generate lines for Base Type.
                % Give random accessName, local variable to store the data
                childAccessName = generateRandomString();
                outlines = obj.BaseType.generateDecoderFunction( ...
                    childAccessName,  nestLevel+1);
                functionScript = vertcat(functionScript, outlines);
                functionScript = vertcat(functionScript, ...
                    sprintf("%s(%s) = %s;", ...
                    arrayName, indexLoop, childAccessName));

                functionScript = vertcat(functionScript, sprintf("end"));


            end


            % This matrix has no size, we must get the entire matrix
            if numel(obj.Dimension)>1
                functionScript = vertcat(functionScript, ...
                    strcat(sprintf("%s = reshape(%s, [", accessName, arrayName), ...
                    sprintf('%i ', obj.Dimension), ...
                    sprintf(']);')));
            else
                functionScript = vertcat(functionScript, ...
                    strcat(sprintf("%s = reshape(%s, 1, []);", accessName, arrayName)));
            end

            % Increase arrayPointer;
            functionScript = vertcat(functionScript, ...
                sprintf("arrayPointer = arrayPointer + %i; %% Padding", ...
                obj.Padding));



        end

        %% function castType = getCastType(obj)
         function castType = getCastType(obj)
            castType = obj.BaseType.MATLABCastType;
         end
    end
end