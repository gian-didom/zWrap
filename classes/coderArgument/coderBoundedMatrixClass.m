classdef (HandleCompatible) coderBoundedMatrixClass < coderBoundedMatrix
    %UNTITLED9 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        
    end

    methods
        %% function obj = coderBoundedMatrixClass(typeObj)
        function obj = coderBoundedMatrixClass(typeObj)
            obj@coderBoundedMatrix(typeObj.Elements(1), typeObj.Elements(2));
            obj.DataType.Name = 'data';
            obj.SizeType.Name = 'size';

            % Alignment requirement
            % For this kind of matrix, everything is enclosed in the
            % structure. According to the rules for struct aligment, the
            % alignment requirement of the structure is given by the
            % strictiest requirement among the ones of  its members.
            % We cannot tell wether the DataType or the SizeType are more
            % constraining, so we must take into account the max of both.
            dataTypeBaseSize = obj.DataType.BaseType.AlignmentRequirement;
            sizeTypeBaseSize = obj.SizeType.BaseType.AlignmentRequirement;
            obj.AlignmentRequirement = max(dataTypeBaseSize, sizeTypeBaseSize);


            obj.setMATLABCastType();
        end


        %% function printTree(obj, indent)
        function printTree(obj, indent)
            printTree@coderArgument(obj, indent);

            fprintf(bopen() + "%s" + bclose() + "[%s] \n", obj.Name, obj.MATLABName);
            obj.DataType.printTree(indent+1);
            obj.SizeType.printTree(indent+1);
        end

    end
end