classdef (HandleCompatible) coderArgument < matlab.mixin.Heterogeneous & handle
    %CODERINPUT Summary of this class goes here
    %   Detailed explanation goes here

    %%
    properties (SetObservable)
        Name = ''
        argNames = {}
        Type = ''
        MATLABType = ''
        MATLABCastType = ''
        MATLABName = ''
        ByteSize = NaN
        TypeSize = 1
        PaddedSize = NaN
        Padding = 0
        AlignmentRequirement = 1
        Children = [];
        isStruct = false;
        isCell = false;
        isClass = false;
        isDirectInput = false;
        isDataType = false;
        isSizeArray = false;
        hasSizeArray = false;
        memoryOffset = 0;
        Role = ''
        originalObject
        Coder = 'MATLAB'
        passedBy = 'value'  %'value' or 'pointer'
    end

    %%
    methods
        %% function obj = coderArgument(codeInfoObject)
        function obj = coderArgument(codeInfoObject)
            if nargin == 0
                return
            end
            %CODERINPUT Construct an instance of this class
            %   Detailed explanation goes here
            obj.originalObject = codeInfoObject;
        end

        %% function obj = setName(obj, name)
        function obj = setName(obj, name)
            obj.Name = name;
            if isempty(obj.argNames) || isempty(obj.argNames{1})
                obj.argNames = {obj.Name};
            end

        end

        %% name = getCppArgumentForCall(obj, baseName)
        function name = getCppArgumentForCall(obj, baseName)

            switch obj.passedBy
                case 'pointer'
                    name = strcat('&(', baseName, '->', obj.Name, ')');

                otherwise
                    name = strcat(baseName, '->', obj.Name);
            end

        end

        %% function td = getCppDeclaration(obj)
        function td = getCppDeclaration(obj)

            td = sprintf("%s %s;", obj.Type, obj.Name);

        end


        %% function totalSizeBytes = getTotalSize(obj)
        % Function to get the Size
        function totalSizeBytes = getTotalSize(obj)

            % If it's a base type it's easy to obtain it
            totalSizeBytes = 0;
            if not(isnan(obj.ByteSize)) && isempty(obj.Children)
                totalSizeBytes = obj.ByteSize;
                return;
            elseif numel(obj.Children)>0
                % If not you must count the Children
                for j=1:numel(obj.Children)
                    totalSizeBytes = totalSizeBytes + obj.Children(j).getTotalSize();
                end
            else
                error("No information to retrieve the size. Maybe size=0?");
            end

            obj.ByteSize = totalSizeBytes;
        end

        %% function totalSizePaddedBytes = getTotalSizePadded(obj)
        % Function to get the padded size
        function totalSizePaddedBytes = getTotalSizePadded(obj)

            % If it's a base type it's easy to obtain it
            totalSizeBytes = 0;
            if isempty(obj.Children)
                totalSizeBytes = obj.ByteSize;
            else


                % If not you must count the Children
                for j=1:numel(obj.Children)
                    totalSizeBytes = totalSizeBytes + obj.Children(j).getTotalSizePadded();
                end
            end

            if mod(totalSizeBytes, 8) > 0
                obj.Padding = ceil(totalSizeBytes/8)*8 - totalSizeBytes;
            end

            totalSizePaddedBytes = totalSizeBytes + obj.Padding;
            obj.PaddedSize = totalSizePaddedBytes;
            return;

        end


        %% function allSubChildren = getFlattenedChildList(obj)
        function allSubChildren = getFlattenedChildList(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here

            allSubChildren = [];
            if not(obj.isDataType)
                for j=1:numel(obj.Children)
                    subChildren = getFlattenedChildList(obj.Children(j));
                    allSubChildren = appendCell(allSubChildren, subChildren);
                end
            else
                allSubChildren = [obj];
            end
        end


        %% function printTree(obj, indent)
        function printTree(obj, indent)
            if nargin == 1
                indent = 0;
            end

            % Print header
            for j=1:indent
                fprintf('   |');
            end
            fprintf('\n');
            for j=1:indent
                fprintf('   |');
            end
            if indent > 0
                fprintf('--');
            end

            % Each object has its own printSignature.
            % We treat arrays as structures with a single layer - the
            % BaseType

        end

        function generateMATLABFunction(obj, accessName)
            % This is abstract and should be overridden.

        end



    end


    %%
    methods(Sealed)

        %% function out = hasChildren(obj)
        function out = hasChildren(obj)
            out = (numel(obj.Children) > 0);
        end

        %% function obj = setMATLABCastType(obj)
        function obj = setMATLABCastType(obj)
            switch obj.MATLABType

                case 'logical'
                    obj.MATLABCastType = 'uint8';
                case 'char'
                    obj.MATLABCastType = 'uint8';
                otherwise
                    obj.MATLABCastType = obj.MATLABType;

            end
        end

    end

    % function getDataRepresentation(obj, matlabVariable)
    %     % This gets the data representation.
    %
    %
    %     dataRepr = uint8([]);
    %     allChild = obj.getFlattenedChildList();
    %
    %     childrenLeft = numel(allChild); % This is the amount of children we have to fill
    %     childrenIndex = 1;
    %     for j=1:numel(varargin)
    %         [fcnRepr, fcnCheck] = allChild(j).getMappingFunction();
    %         if not(fcnCheck)
    %         dataRepr =
    %     dataRepr = horzcat(dataRepr, allChild(j).getDataRepresentation)
    %     end
    % end
    %
    % methods(Abstract)
    %     dataRepr = mappingFunction(inobj, inputVariable);
    %     outputVariable = buildingFunction(inobj, inputStream);
    % end

    %%


    methods(Static)




        %% function outobj = processObject2(inobj, varargin)
        % This is the factory function.
        function outobj = processObject2(inobj, varargin)

            if isa(inobj, 'RTW.DataInterface')
                % This block is executed in case the passed object is of
                % type RTW.DataInterface. This kind of objects represent
                % level-0 MATLAB inputs.
                % They have to be represented as fields of the parent input
                % structure.
                impl = inobj.Implementation;
                switch class(impl)

                    case {'RTW.Variable', 'RTW.StructExpression'}
                        if isprop(impl, 'Identifier')
                            idFieldName = 'Identifier';
                        elseif isprop(impl, 'ElementIdentifier')
                            idFieldName = 'ElementIdentifier';
                        else
                            error('No Identifier field in structure');
                        end

                        outobj = coderArgument.processObject2(impl.Type);

                        % Augment with name information
                        outobj.setName(impl.(idFieldName));
                        outobj.MATLABName = impl.(idFieldName);

                    case 'RTW.TypedCollection'
                        % This is split between two elements, but actually
                        % is a single Matrix or Cell istance with the _data
                        % and _size variables.
                        % We need a special class for this object, as we
                        % need to RETAIN this type of information
                        outobj = coderBoundedMatrixCollection(impl);
                        outobj.setName(inobj.GraphicalName);
                        outobj.MATLABName = inobj.GraphicalName;

                    otherwise
                        error('This case is not covered yet.')
                end

                return;
            else
                % This is a deeper-level nested object or reduced variable
                % and does not require special implementation.

                switch class(inobj)

                    case {'coder.types.Struct', 'coder.types.Class'}
                        % Check wether it is a structure or a cell
                        objTargetClass = coderNestedObject.disambiguate(inobj);
                        outobj = objTargetClass(inobj);

                    case 'coder.types.Matrix'
                        % This is the matrix type, but for the 1x1 case it
                        % collapses to a Primitive
                        if all(inobj.Dimensions == 1)
                            outobj = coderPrimitive(inobj.BaseType);
                        else
                            outobj = coderFixedMatrix(inobj);
                        end

                    otherwise
                        % This is a lower-level or an error
                        if isprop(inobj, 'WordLength')
                            % Base type
                            outobj = coderPrimitive(inobj);
                        else
                            error('Don''t know what to do.');
                        end
                end

            end

        end

        %% function outobj = processObject(inobj, varargin)
        % Legacy
        % function outobj = processObject(inobj, varargin)
        %
        %     isDirectInput = false;
        %     if isa(inobj, 'RTW.DataInterface')
        %         % Mark as dfault input and continue with impl
        %         isDirectInput = true;
        %         inobj = inobj.Implementation;
        %     end
        %
        %     switch class(inobj)
        %
        %         case 'RTW.TypedCollection'
        %             % This MATLAB input has been expanded in multiple elements
        %             outobj = arrayfun(@(x,j) coderArgument.processObject(x,mod(j,2)==1, mod(j,2)==0), inobj.Elements, 1:numel(inobj.Elements));
        %             return;
        %
        %         case 'RTW.Variable'
        %             % Array type case
        %             if any(strcmp(fields(inobj.Type), 'BaseType'))
        %                 outobj = coderMatrix(inobj, varargin{:});
        %                 return;
        %             end
        %
        %             % Struct case
        %             if isa(inobj.Type, 'coder.types.Struct')
        %                 outobj = coderStructure(inobj,varargin{:});
        %                 return;
        %             end
        %
        %             %
        %             if any(strcmp(fields(inobj.Type), 'WordLength'))
        %                 outobj = coderBaseType(inobj, varargin{:});
        %
        %             else
        %                 error('Not covered');
        %             end
        %
        %
        %         case {'RTW.AggregateElement', 'coder.types.AggregateElement'}
        %
        %             if any(strcmp(fields(inobj.Type), 'Elements'))
        %
        %                 % Check if is a data-size type of object
        %                 if (numel(inobj.Type.Elements) == 2 && strcmp(strrep(inobj.Type.Elements(1).Identifier, 'data', 'size'), inobj.Type.Elements(2).Identifier))
        %                     outobj = coderMatrixStructure(inobj, varargin{:});
        %                 else
        %                     outobj = coderStructure(inobj, varargin{:});
        %                 end
        %                 return;
        %             end
        %
        %             if any(strcmp(fields(inobj.Type), 'BaseType'))
        %                 outobj = coderMatrix(inobj, varargin{:});
        %                 return;
        %             end
        %
        %             if any(strcmp(fields(inobj.Type), 'WordLength'))
        %                 outobj = coderBaseType(inobj, varargin{:});
        %                 return;
        %             end
        %
        %             % If we are here...
        %             error("Not covered.");
        %
        %         otherwise
        %             error("The handling of %s has not been implemented yet.", class(inobj));
        %
        %     end
        % end

    end
end

