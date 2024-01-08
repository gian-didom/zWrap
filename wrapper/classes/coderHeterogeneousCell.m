classdef (HandleCompatible) coderHeterogeneousCell < coderNestedObject
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here

    properties
    end

    methods
        function obj = coderHeterogeneousCell(typeObj, varargin)
            obj@coderNestedObject(typeObj)
            obj.MATLABType = 'cell';
            obj.isCell = true;
            obj.setMATLABCastType();
            warning("Simulink does not support cell array as signals. " + ...
                "If you want to avoid errors in the generation of the Simulink block, " + ...
                "re-run zWrap with the -simcelltostruct option.")
        end

        function [fcn, checkFcn] = getMappingFunction(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if (obj.hasSizeArray && not(obj.isSizeArray))
                fcn = @(x) typecast(cast(reshape(x, numel(x), 1),obj.MATLABType), 'uint8');
                return;
            end

            if (obj.isSizeArray && not(obj.hasSizeArray))
                fcn = @(x) typecast(cast(size(x), 'int32'), obj.Type);
            end

            % Check
            checkFcn = @(x) (numel(fcn(x)) == obj.Size);
        end


        function outvar = getTemplate(obj)
            outvar = cell(size(obj.Children, 1));
            for j=1:numel(obj.Children)
                outvar{j} = obj.Children(j).getTemplate();
            end

        end



        % Mapping Function
        function fullDataRepr = mappingFunction(obj, inputVariable)
            % Check if is structure
            assert(isstruct(inputVariable), "The input variable is not a structure.");

            % Check if fields overlap, or if at least this object is
            % contained in the parent
            for j=1:numel(obj.Children)
                % Is the MATLAB name of the children included in the input
                % variable fields?
                assert(isfield(inputVariable, obj.Children(j).MATLABName));
            end

            % If we're here, yes. Structure can be overlapped. Proceed
            % recursively over the fields:

            fullDataRepr = uint8([]);

            for j=1:numel(obj.Children)

                % get da
                dataRepr = obj.Children(j).mappingFunction(inputVariable.(obj.Children(j).MATLABName));
                assert(obj.Children(j).checkFunction(dataRepr));

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
            % Gets MATLAB object from associated stream
            assert(numel(inputStream) >= obj.Size, "The stream should be bigger than the object size.");

            % It's a structure, so let's initialize it
            outputVariable = struct();

            % Iterate over the Children. Each Children should have an
            % associated MATLAB name and an associated buildingFunction that
            % returns the associated variable(s) to put in the structure
            % field.
            streamPointer = 1;
            for j=1:numel(obj.Children)
                inputArgs = {};
                sizePadding = 0;
                if obj.Children(j).hasSizeArray
                    inputArgs(end+1) = {obj.Children(j+1)};
                    sizePadding = obj.Children(j+1).PaddedSize;
                elseif obj.Children(j).isSizeArray
                    continue;
                end
                outputVariable.(obj.Children(j).MATLABName) = obj.Children(j).buildingFunction(inputStream(streamPointer:end), inputArgs{:});
                streamPointer = streamPointer + obj.Children(j).PaddedSize + sizePadding;
            end
        end

        %% function functionScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateMATLABFunction(obj, accessName, nestLevel)
            % The accessName is given from the parent

            cellName = generateRandomString();

            functionScript = {};
            % This is a struct, so we need multiple lines
            % functionScript = vertcat(functionScript, sprintf("%s_cell = %s;", cellName, accessName));

            for j=1:numel(obj.Children)
                % This trick helps accessing the elements of the cell.
                % A function call to a generic getContent - that unwraps
                % the content of the cell - is not sufficient, because we
                % cannot concatenate.
                % An alternative approach is to extract the cell content
                % first and then proceed.
                functionScript = vertcat(functionScript, ...
                    sprintf('%s_content%i = %s{%i};', cellName, j, accessName, j));
                outlines = obj.Children(j).generateMATLABFunction( ...
                     sprintf('%s_content%i', cellName, j), nestLevel);
                % outlines = obj.Children(j).generateMATLABFunction( ...
                %     sprintf('cell2struct(%s_cell(%i), "f").f', cellName, j), nestLevel);
                functionScript = vertcat(functionScript, outlines);
            end
            % lhs = sprintf('byteArray[%i:%i+%i] ', obj.memoryOffset, obj.memoryOffset, obj.ByteSize);
            % rhs = sprintf('typecast%s')

        end

        %% function functionScript = generateDecoderFunction(obj, accessName)
        function functionScript = generateDecoderFunction(obj, accessName, nestLevel)
            % The accessName is given from the parent

            functionScript = {};
            % This is a cell, so we need multiple lines
            cellArrayName = generateRandomString();


            functionScript = {};
            % This is a struct, so we need multiple lines 
            for j=1:numel(obj.Children)
                outlines = obj.Children(j).generateDecoderFunction(sprintf("%s{%i}", cellArrayName, j), nestLevel);
                functionScript = vertcat(functionScript, outlines);
            end


            functionScript = vertcat(functionScript, sprintf("%s = %s;", accessName, cellArrayName));

            

            % Increase arrayPointer;
            functionScript = vertcat(functionScript, ...
                sprintf("arrayPointer = arrayPointer + %i;", ...
                obj.Padding));


        end
    end
end