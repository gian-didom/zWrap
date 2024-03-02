classdef (HandleCompatible) coderArgumentFactory
    %CODERINPUT Summary of this class goes here
    %   Detailed explanation goes here

    %%
    properties (SetObservable)
       originalObject = codeInfoObject;
    end


    %% Constructor method. 
    methods % (Constructor)

        %% methods ------------------------------------------------------------------
        %% function obj = coderArgument(codeInfoObject)
        function obj = coderArgumentFactory(codeInfoObject)
            if nargin == 0
                return
            end
            %CODERINPUT Construct an instance of this class
            %   Detailed explanation goes here
            obj.originalObject = codeInfoObject;
        end
        %% ==========================================================================

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
                outobj = coderArgumentFactory.processRTWDataInterface(inobj, varargin); % Delegate to RTW object factory.
                return;
                
            else % is a plain object.
                % This is a deeper-level nested object or reduced variable
                % and does not require special implementation.
                outobj = coderArgumentFactory.processPlainObject(inobj, varargin);
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
                    
                    outobj = coderArgumentFactory.processObject(impl.Type);

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
                    outobj_temp = coderArgumentFactory.processObject(inobj.BaseType);

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

