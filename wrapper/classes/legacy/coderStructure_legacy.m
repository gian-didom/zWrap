classdef (HandleCompatible) coderStructure_legacy < coderArgument
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here

    properties
    end

    methods
        function obj = coderStructure(codeInfoObject, varargin)
            if nargin==0 
                return
            end
            %UNTITLED7 Construct an instance of this class
            %   Detailed explanation goes here
            obj.Name = codeInfoObject.Identifier;
            obj.MATLABName = codeInfoObject.Identifier;
            obj.MATLABType = 'struct';
            if any(strcmp(fields(codeInfoObject.Type), 'Elements'))
                for j=1:numel(codeInfoObject.Type.Elements)
                        output = coderArgument.processObject(codeInfoObject.Type.Elements(j), varargin{:});
                        obj.Children = appendCell(obj.Children, output);
                        

                end

                else

                error("The handling of %s has not been codeInfoObjectemented yet.", class(codeInfoObject));
            end
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
    end
end