classdef (HandleCompatible) coderBoundedMatrixCollection < coderBoundedMatrix
    %UNTITLED9 Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods
        %%
        function obj = coderBoundedMatrixCollection(typeObj)
            obj@coderBoundedMatrix(typeObj.Elements(1), typeObj.Elements(2));
            % Alignment requirement
            % For this kind of matrix, the requirement of alignment is
            % given by the DataType object. Indeed, it is the first one
            % that appears in the structure and, therefore, the alignment
            % is governed by him.
            % Eventually, padding could be added after the _data object to
            % properly align the _size object.
            obj.AlignmentRequirement = obj.DataType.AlignmentRequirement;
            obj.setMATLABCastType();

            obj.DataType.Dimension = obj.DataType.NumEl;
        end

        function obj = setName(obj, name)
            obj.Name = name;
            obj.DataType.Name = strcat(obj.Name, '_data');
            obj.SizeType.Name = strcat(obj.Name, '_size');
            obj.argNames = {obj.DataType.Name; obj.SizeType.Name};
        end


        %% function name = getCppArgumentForCall(obj, baseName)
        function name = getCppArgumentForCall(obj, baseName)

            
                name = {obj.DataType.getCppArgumentForCall(baseName);
                    obj.SizeType.getCppArgumentForCall(baseName)};

           
        end

        %%
        function td = getCppDeclaration(obj)
            if isa(obj.SizeType, "coderPrimitive")
                
                sizeDecl = char(strcat(getCppDeclaration(obj.SizeType)));
                sizeDecl = char(strcat(sizeDecl(1:end-1), "[1];"));
                td = {getCppDeclaration(obj.DataType);
                    sizeDecl};
            else

                td = {getCppDeclaration(obj.DataType);
                    getCppDeclaration(obj.SizeType)};
            end
        end

        %%
        function printTree(obj, indent)
            printTree@coderArgument(obj, indent);


            fprintf('<strong>%s_data</strong> [%s] ', obj.Name, obj.MATLABName);
            fprintf('<%s[%i]> (',obj.DataType.BaseType.Type, obj.DataType.NumEl);
            
            for j=1:numel(obj.DataType.Dimension)-1
                fprintf('%ix', obj.DataType.Dimension(j));
            end

            fprintf('%i %s)\n',  obj.DataType.Dimension(end), obj.DataType.BaseType.MATLABType)

            obj.DataType.BaseType.printTree(indent+1);

            printTree@coderArgument(obj, indent);

            fprintf('<strong>%s_size</strong> [%s] ', obj.Name, obj.MATLABName);
            % Hotfix
            if isa(obj.SizeType, "coderPrimitive")
                fprintf('<%s[%i]> (',obj.SizeType.Type, 1);
            else
                fprintf('<%s[%i]> (',obj.SizeType.BaseType.Type, obj.SizeType.NumEl);
            end

            if isa(obj.SizeType, "coderPrimitive")
                fprintf('%ix', 1);
            else
                for j=1:numel(obj.SizeType.Dimension)-1
                    fprintf('%ix', obj.SizeType.Dimension(j));
                end
                fprintf('%i %s)\n',  obj.SizeType.Dimension(end), obj.SizeType.BaseType.MATLABType)
                obj.SizeType.BaseType.printTree(indent+1);

            end



        end
    end
end