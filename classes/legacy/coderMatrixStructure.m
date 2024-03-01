classdef (HandleCompatible) coderMatrixStructure < coderArgument
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here

    properties
    end

    methods
        function obj = coderMatrixStructure(codeInfoObject, varargin)
            %UNTITLED7 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Name = codeInfoObject.Identifier;
            obj.MATLABName = obj.Name;
            if any(strcmp(fields(codeInfoObject.Type), 'Elements'))

                for j=1:numel(codeInfoObject.Type.Elements)
                    output = coderArgument.processObject(codeInfoObject.Type.Elements(j), mod(j,2), mod(j+1,2));
                    output.MATLABName = obj.MATLABName;

                    obj.Children = appendCell(obj.Children, output);
                end

            else

                error("The handling of %s has not been codeInfoObjectemented yet.", class(codeInfoObject));
            end
        end

        function fullDataRepr = mappingFunction(obj, inputVariable)
            % Check if is structure
            assert(ismatrix(inputVariable), "The input variable is not a matrix.");

            % If we're here, yes. Structure can be overlapped. Proceed
            % recursively over the fields:

            fullDataRepr = uint8([]);

            for j=1:numel(obj.Children)

                % get da
                dataRepr = obj.Children(j).mappingFunction(inputVariable);
                assert(obj.Children(j).checkFunction(dataRepr), 'Check for Children failed');

                % Add variable to structure representation
                fullDataRepr = vertcat(fullDataRepr, dataRepr(:));

                % Add padding if present
                fullDataRepr = vertcat(fullDataRepr, uint8(zeros(obj.Children(j).Padding, 1)));
            end
            
            assert(obj.checkFunction(fullDataRepr))
        end

        function isGood = checkFunction(obj, dataRepr)
            isGood = numel(dataRepr) == obj.PaddedSize;
        end


        function outputVariable = buildingFunction(obj, inputStream, varargin)
           assert(numel(inputStream) >= obj.Size, "The stream should be bigger than the object size.");
            % This matrix in general has just two elements: one is the
            % data, and one is the size. We must first initialize the size
            % of the allay to allocate it.
            streamPointer = 1;
            for j=1:numel(obj.Children)
                if obj.Children(j).isSizeArray
                    % Then no need to use it.
                    continue;
                end

                if obj.Children(j).hasSizeArray 
                    % Then we must find the size
                    sizeStreamPointer = streamPointer + obj.Children(j).PaddedSize;
                    arraySize = typecast(inputStream(sizeStreamPointer:obj.Children(j+1).Size+sizeStreamPointer-1), obj.Children(j+1).MATLABType);
                    arraySize = reshape(arraySize, 1, []);
                    
                    typeSize = obj.Children(j).ByteSize/ obj.Children(j).NumEl;
                    endPointerLocation = prod(arraySize)*typeSize;
                    arrayData = typecast(inputStream(1:endPointerLocation), obj.Children(j).MATLABType);
                    outputVariable = reshape(arrayData, arraySize);
                end
            end
           
        end
    end
end