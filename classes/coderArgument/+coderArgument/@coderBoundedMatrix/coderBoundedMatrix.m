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

    end
end