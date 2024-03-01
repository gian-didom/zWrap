classdef (HandleCompatible, Abstract) coderNestedObject < coderArgument
    %UNTITLED7 Summary of this class goes here
    %   Detailed explanation goes here

    properties

    end

    methods
        %% function obj = coderNestedObject(typeObj)
        function obj = coderNestedObject(typeObj)
            
                obj@coderArgument(typeObj);
            %UNTITLED7 Construct an instance of this class
            %   Detailed explanation goes here
            if class(typeObj) == "RTW.ComponentInterface"
                return
            end
            assert(any(strcmp(fields(typeObj), 'Elements')), 'This heterogeneous cell has no elements.')

            % Fill standard information
            % C++ type
            obj.Type = typeObj.Identifier;

            % Name and MATLABName are given outside as they are part of the
            % Element/Implementation object.


            % Iterate on the Elements
            numChildren = numel(typeObj.Elements);
            for j=1:numChildren
                output = coderArgument.processObject2(typeObj.Elements(j).Type);
                output.setName(typeObj.Elements(j).Identifier);
                output.MATLABName = typeObj.Elements(j).Identifier;
                obj.Children = horzcat(obj.Children, output);
            end

            obj.AlignmentRequirement = max(arrayfun(@(x) x.AlignmentRequirement, obj.Children));

            obj.setMATLABCastType();


        end


        %% function name = getCppArgumentForCall(obj, baseName)

        function name = getCppArgumentForCall(obj, baseName)
            % TODO: Check with codeinfo if to pass by reference
            % Default: yes
            switch obj.passedBy
                case "pointer"
                name = strcat('&(', baseName, '->', obj.Name, ')');
                otherwise
                name = strcat(baseName, '->', obj.Name);
            end
        end


        %% function bytesize = getTotalSize(obj)
        function bytesize = getTotalSize(obj)

            % Simply iterate over the children
            bytesize = 0;
            for j=1:numel(obj.Children)
                bytesize = bytesize + obj.Children(j).getTotalSize();
            end
            obj.ByteSize = bytesize;
        end

        %% function paddedSize = getTotalSizePadded(obj)
        function paddedSize = getTotalSizePadded(obj)

            % Add padding and compute size
            paddedSize = 0;
            for j=1:numel(obj.Children)
                obj.Children(j).memoryOffset = obj.memoryOffset + paddedSize;
                if j<numel(obj.Children)
                    obj.Children(j).Padding = -mod(paddedSize + obj.Children(j).getTotalSizePadded(), -obj.Children(j+1).AlignmentRequirement);
                else
                    % We're at end - structure must be divisible by max of
                    % its Child, so you can put them in one array.
                    obj.Children(j).Padding = -mod(paddedSize + obj.Children(j).getTotalSizePadded(), -obj.AlignmentRequirement);

                end
                paddedSize = paddedSize + obj.Children(j).getTotalSizePadded() + obj.Children(j).Padding;
            end

            obj.PaddedSize = paddedSize;
        end

        %% function printTree(obj, indent)
        function printTree(obj, indent)

            if nargin==1
                indent=0;
            end
            printTree@coderArgument(obj, indent);


            fprintf(bopen() + "%s" + bclose() + "[%s] <%s>\n", obj.Name, obj.MATLABName, obj.Type);
            % fprintf('<%s[%i]> (',obj.Type, obj.NumEl);
            % for j=1:numel(obj.Dimension)-1
            %     fprintf('%ix', obj.Dimension(j));
            % end
            % fprintf('%i %s)\n',  obj.Dimension(end), obj.MATLABType)


            if obj.hasChildren()

                for j=1:numel(obj.Children)
                    obj.Children(j).printTree(indent+1);
                end

            end

        end

    end




    % Static methods
    methods (Static)
        %% function outobj = create(inobj)
        function outClass = disambiguate(inobj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            if strcmp(inobj.Identifier(1:4), 'cell')
                outClass = @coderHeterogeneousCell;
            elseif strcmp(inobj.Identifier(1:6), 'struct') || isa(inobj, "coder.types.Struct")
                outClass = @coderStructure;
            else % It should be a class
                outClass = coderClass.disambiguate(inobj);
            end
        end
    end
end