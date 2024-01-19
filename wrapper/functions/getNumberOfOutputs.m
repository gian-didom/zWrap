function [numOutputs,nameOutputs, typeOutputs, sizeOutputs] = getNumberOfOutputs(codeInfo)
%GETNUMBEROFOutputs Summary of this function goes here
%   Detailed explanation goes here
numOutputs = 0;
nameOutputs = [];
typeOutputs = [];
sizeOutputs = [];

for j=1:numel(codeInfo.Outports)
    obj = codeInfo.Outports(j);
    impl = codeInfo.Outports(j).Implementation;

    if isprop(impl, 'Identifier')
        fieldName = impl.Identifier;
    elseif isprop(impl, 'ElementIdentifier')
        fieldName = impl.ElementIdentifier;
    elseif isprop(obj, 'GraphicalName')
        fieldName = obj.GraphicalName';
    else
        error('No Identifier field in structure');
    end

    % Check if single or multi
    if ~any(strcmp(fields(impl),'Elements'))
        numOutputs = numOutputs + 1;
        nameOutputs = [nameOutputs; string(fieldName)];
        if any(strcmp(fields(impl.Type),'BaseType'))
            typeOutputs = [typeOutputs; string(impl.Type.BaseType.Identifier)];
            sizeOutputs = [sizeOutputs; prod(impl.Type.Dimensions)];
        else
            typeOutputs = [typeOutputs; string(impl.Type.Identifier)];
            sizeOutputs = [sizeOutputs; 1];

        end
    else
        numOutputs = numOutputs + numel(impl.Elements);
        for k = 1:numel(impl.Elements)
            nameOutputs = [nameOutputs; string(impl.Elements(k).Identifier)];

            if any(strcmp(fields(impl.Elements(k).Type),'BaseType'))
                typeOutputs = [typeOutputs; string(impl.Elements(k).Type.BaseType.Identifier)];
                sizeOutputs = [sizeOutputs; prod(impl.Elements(k).Type.Dimensions)];

            else
                typeOutputs = [typeOutputs; string(impl.Elements(k).Type.Identifier)];
                sizeOutputs = [sizeOutputs; 1];

            end
        end
    end

end
end

