classdef (HandleCompatible) coderClass < coderNestedObject
    %UNTITLED9 Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods
        function obj = coderClass(typeObj)
            obj@coderNestedObject(typeObj);
            obj.isClass = true;
            obj.setMATLABCastType();
        end

        
        
        %% function functionScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateMATLABFunction(obj, accessName)
            % The accessName is given from the parent

            functionScript = {};
            warning("This has not been implemented yet.");

        end



    end


    methods(Static)
        function outobj = create(typeObj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            switch typeObj.Identifier
                case 'bounded_array'
                    % It is not a real class. It is a bounded matrix.
                    outobj = coderBoundedMatrixClass(typeObj);
                otherwise
                    % It could be a String, maybe?
                    if coderClass.checkIsString(typeObj)
                        % Strings are managed exactly as traditional nested
                        % objects. However, they have a different
                        % implementation for the streaming and building
                        % function.
                        outobj = coderString(typeObj);
                    else

                    % Then it's a generic class
                    outobj = coderClass(typeObj);
                    end
            end
        end

        function isString = checkIsString(typeObj)
        isString = false;
        % Check if identifier contains string
        if numel(strfind(typeObj.Identifier, 'String')) == 0; return; end

        % Check if has a "Value" element
        if numel(typeObj.Elements) < 1; return; end
        if not(strcmp(typeObj.Elements(1).Identifier, 'Value')); return; end
        
        % If we are here, then it's a string.
        isString = true;
        end
    end
end