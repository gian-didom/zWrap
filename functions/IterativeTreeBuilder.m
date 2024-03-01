function [out] = IterativeTreeBuilder(codeInfoObject)


switch class(codeInfoObject)

    case 'RTW.ComponentInterface'
        % We're at the top level - this is the top-level structure!
        out.Type = 'struct';
        out.Size = NaN;         % Right now, not a number
        out.Name = 'FULL_INPUT_STRUCTURE';
        out.Dimension = 1;
        out.Padding = 0;
        out.Children = [];
        for j=1:numel(codeInfoObject.Inports)
            out.Children = [out.Children; IterativeTreeBuilder(codeInfoObject.Inports(j))];
        end

    case 'RTW.DataInterface'
        % Normal data interface - typical this is a single MATLAB input.
        impl = codeInfoObject.Implementation;
        switch class(impl)
            case 'RTW.TypedCollection'
                % This MATLAB input has been expanded in multiple elements
                out = [struct('Name', '', 'Size', NaN, 'Type', '', 'Dimension', 1, 'Padding', 0, 'Children', [])];
                for j=1:numel(impl.Elements)
                    out = vertcat(out, IterativeTreeBuilder(impl.Elements(j)));
                end

            case 'RTW.Variable'
                out.Padding = 0;
                out.Children = [];
                out.Name = impl.Identifier;
                out.Type = impl.Type.Identifier;
                out.Dimension = 1;
                out.Size = NaN;
                if any(strcmp(fields(impl.Type), 'BaseType'))
                    out.Dimension = prod(impl.Type.Dimensions);
                    out.Size = out.Dimension * impl.Type.BaseType.WordLength/8;
                    out.Type = impl.Type.BaseType.Identifier;
                elseif strcmp(class(impl.Type), 'coder.types.Struct')

                    if any(strcmp(fields(impl.Type), 'Elements'))
                        for j=1:numel(impl.Type.Elements)
                            out.Children = [out.Children; IterativeTreeBuilder(impl.Type.Elements(j))];
                        end
                    else
                        error("The handling of %s has not been implemented yet.", class(impl));

                    end
                elseif any(strcmp(fields(impl.Type), 'WordLength'))
                    out.Dimension = 1;
                    out.Size = out.Dimension * impl.Type.WordLength/8;
                    out.Type = impl.Type.Identifier;

                else
                    error('Not covered');
                end
            otherwise
                error("The handling of %s has not been implemented yet.", class(impl));
        end

    case {'RTW.AggregateElement', 'coder.types.AggregateElement'}
        out.Padding = 0;
        out.Children = [];
        out.Name = codeInfoObject.Identifier;
        out.Type = codeInfoObject.Type.Identifier;
        out.Dimension = 1;
        out.Size = NaN;
        if any(strcmp(fields(codeInfoObject.Type), 'Elements'))
            for j=1:numel(codeInfoObject.Type.Elements)
                out.Children = [out.Children; IterativeTreeBuilder(codeInfoObject.Type.Elements(j))];
            end
        else

            if any(strcmp(fields(codeInfoObject.Type), 'BaseType'))
                out.Dimension = prod(codeInfoObject.Type.Dimensions);
                out.Size = out.Dimension * codeInfoObject.Type.BaseType.WordLength/8;
                out.Type = codeInfoObject.Type.BaseType.Identifier;
            elseif any(strcmp(fields(codeInfoObject.Type), 'WordLength'))
                out.Dimension = 1;
                out.Size = out.Dimension * codeInfoObject.Type.WordLength/8;
                out.Type = codeInfoObject.Type.Identifier;

            else
                error("Not covered.");
            end
        end


    case 'RTW.Variable'
        % This is typically a nested object.
        out.Name = codeInfoObject.Identifier;
        out.Dimension = 1;
        out.Size = NaN;
        if any(strcmp(fields(codeInfoObject.Type), 'BaseType'))
            out.Dimension = prod(codeInfoObject.Type.Dimensions);
            out.Size = out.Dimension * codeInfoObject.Type.BaseType.WordLength/8;
            out.Type = codeInfoObject.Type.BaseType.Identifier;

        elseif any(strcmp(fields(codeInfoObject.Type), 'WordLength'))
            out.Dimension = 1;
            out.Size = out.Dimension * codeInfoObject.Type.WordLength/8;
            out.Type = codeInfoObject.Type.Identifier;

        else
            error("Not covered.");
        end
        out.Padding = 0;
        out.Children = [];


end


end