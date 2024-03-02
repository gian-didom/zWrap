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


    %% Constructor method. 
    methods % (Constructor)

        %% methods ------------------------------------------------------------------
        %% function obj = coderArgument(codeInfoObject)
        function obj = coderArgument(codeInfoObject)
            if nargin == 0
                return
            end
            %CODERINPUT Construct an instance of this class
            %   Detailed explanation goes here
            obj.originalObject = codeInfoObject;
        end
        %% ==========================================================================

    end


    %% Normal methods. These methods have an implementation in the super class.
    % They may be overridden (or not) in the subclasses.
    methods

        %% methods ------------------------------------------------------------------
        %% function obj = setName(obj, name)
        function obj = setName(obj, name)
            obj.Name = name;
            if isempty(obj.argNames) || isempty(obj.argNames{1})
                obj.argNames = {obj.Name};
            end

        end
        %% ==========================================================================




        %% methods ------------------------------------------------------------------
        %% name = getCppArgumentForCall(obj, baseName)
        function name = getCppArgumentForCall(obj, baseName)

            switch obj.passedBy
                case 'pointer'
                    name = strcat('&(', baseName, '->', obj.Name, ')');

                otherwise
                    name = strcat(baseName, '->', obj.Name);
            end

        end
        %% ==========================================================================




        %% methods ------------------------------------------------------------------
        %% function td = getCppDeclaration(obj)
        function td = getCppDeclaration(obj)
            td = sprintf("%s %s;", obj.Type, obj.Name);
        end
        %% ==========================================================================



        %% methods ------------------------------------------------------------------
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
        %% ==========================================================================




        %% methods ------------------------------------------------------------------
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
        %% ==========================================================================




        %% methods ------------------------------------------------------------------
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
        %% ==========================================================================



        %% methods ------------------------------------------------------------------
        %% function printTree(obj, indent)
        function printTree(obj, indent)

            if nargin == 1;     indent = 0;         end

            for j=1:indent;     fprintf('   |');    end % Print header
            fprintf('\n');                              % Print a space
            for j=1:indent;     fprintf('   |');    end % Print tree root
            if indent > 0;      fprintf('--');      end % Print tree branch

            % Each object has its own printSignature, and must override
            % this method while calling the super method.

        end
        %% ==========================================================================
        
    

    end %% methods


    %% Abstract methods. These methods have no implementation in the super class.
    % They MUST be overridden in all non-abstract subclasses.
    methods(Abstract = true)
        % Abstract methods. This functions MUST be concretized in non-abstract children classes.

        %% methods(Abstract = true) -------------------------------------------------------
        %% function generateMATLABFunction(obj, accessName) ===============================
        generateMATLABFunction(obj, accessName);
        %% ================================================================================

    end


    %% Sealed methods. These methods have an implementation in the super class.
    % The MUST NOT be overridden in the subclasses.
    methods(Sealed)

        %% methods(Sealed) --------------------------------------------------------
        %% function  out = hasChildren(obj)
        function out = hasChildren(obj)
            out = (numel(obj.Children) > 0);
        end
        %% ================================================================================
        

        %% methods(Sealed) --------------------------------------------------------
        %% TODO: This method is useless and should be places in the children classes
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
        %% ================================================================================

    end


    %% Static methods. These methods have no access to the object.
    % They are used to implement the factory pattern.
    methods(Static)

        %% methods(Static) --------------------------------------------------------
        %% function outobj = processObject(inobj, varargin)
        % This is the factory function.
        function outobj = processObject(inobj, varargin)

            if isa(inobj, 'RTW.DataInterface')
                % This block is executed in case the passed object is of
                % type RTW.DataInterface. This kind of objects represent level-0 MATLAB inputs.
                % They have to be represented as fields of the parent input structure.
                outobj = coderArgument.processRTWDataInterface(inobj, varargin); % Delegate to RTW object factory.
                return;
                
            else % is a plain object.
                % This is a deeper-level nested object or reduced variable
                % and does not require special implementation.
                outobj = coderArgument.processPlainObject(inobj, varargin);
                return;
                
            end
            
        end
        %% ========================================================================
        


        %% methods(Static) --------------------------------------------------------
        %% function outobj = processRTWDataInterface(inobj, varargin)
        function outobj = processRTWDataInterface(inobj, varargin)

            impl = inobj.Implementation;
            switch class(impl)

                case {'RTW.Variable', 'RTW.StructExpression'}
                    
                    outobj = coderArgument.processObject(impl.Type);

                    % Augment with name information. Name information is 
                    % in the Implementation object either as Identifier
                    % or ElementIdentifier.
                    if isprop(impl, 'Identifier')
                        idFieldName = 'Identifier';
                    elseif isprop(impl, 'ElementIdentifier')
                        idFieldName = 'ElementIdentifier';
                    else
                        error('No Identifier field in structure');
                    end

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

        end
        %% ========================================================================



        % methods(Static) --------------------------------------------------------
        % function outobj = processPlainObject(inobj, varargin)
        function outobj = processPlainObject(inobj, varargin)
            
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


                case 'coder.types.Pointer'
                    % Pointer: try to cast
                    warning("Warning: pointer handling is experimental. Currently, the function only returns the pointer." + ...
                        "This allows to measure memory and execution time but not to retrieve the results.")
                    outobj_temp = coderArgument.processObject(inobj.BaseType);

                    codeInfoObj.Name = 'uint32';
                    codeInfoObj.WordLength = 32;
                    codeInfoObj.Identifier = 'uint32';
                    outobj = coderPrimitive(codeInfoObj);
                    outobj.Role = 'output';
                    outobj.Name = outobj_temp.Name;
                    outobj.MATLABName = outobj_temp.MATLABName;


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
        %% =======================================================================

    end
end

