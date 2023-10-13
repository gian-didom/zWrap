classdef (HandleCompatible) coderString < coderNestedObject
    %UNTITLED9 Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods
        function obj = coderString(typeObj)
            obj@coderNestedObject(typeObj); % Superclass
            obj.isClass = true;

            obj.setMATLABCastType();
        end


        function outvar = getTemplate(obj)
            outvar = obj.Children(1).getTemplate();
        end
        
        
        %% function functionScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateMATLABFunction(obj, accessName, nestLevel)
            % The accessName is given from the parent
            functionScript = obj.Children(1).generateMATLABFunction(accessName, nestLevel+1);
        end


        %% function functionScript = generateMATLABFunction(obj, accessName)
        function functionScript = generateDecoderFunction(obj, accessName, nestLevel)
            % The accessName is given from the parent
            functionScript = obj.Children(1).generateDecoderFunction(accessName, nestLevel+1);

            % Increase arrayPointer;
            functionScript = vertcat(functionScript, ...
                sprintf("arrayPointer = arrayPointer + %i; %% Padding", ...
                obj.Padding)); 

        end

    end


end