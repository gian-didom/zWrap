function [numInputs,nameInputs, typeInputs, sizeInputs] = getNumberOfInputs(codeInfo)
%GETNUMBEROFINPUTS Summary of this function goes here
%   Detailed explanation goes here
numInputs = 0;
nameInputs = [];
typeInputs = [];
sizeInputs = [];

for j=1:numel(codeInfo.Inports)
    impl = codeInfo.Inports(j).Implementation;
    
    if isprop(impl, 'Identifier')
        idFieldName = 'Identifier';
    elseif isprop(impl, 'ElementIdentifier')
        idFieldName = 'ElementIdentifier';
    else
        error('No Identifier field in structure');
    end

    % Check if single or multi
    if ~any(strcmp(fields(impl),'Elements'))
        numInputs = numInputs + 1;
        nameInputs = [nameInputs; string(impl.(idFieldName))];
        if any(strcmp(fields(impl.Type),'BaseType'))
            typeInputs = [typeInputs; string(impl.Type.BaseType.Identifier)];
            sizeInputs = [sizeInputs; prod(impl.Type.Dimensions)];
        else
            typeInputs = [typeInputs; string(impl.Type.Identifier)];
            sizeInputs = [sizeInputs; 1];

        end
    else
        numInputs = numInputs + numel(impl.Elements);
        for k = 1:numel(impl.Elements)
            nameInputs = [nameInputs; string(impl.Elements(k).Identifier)];

            if any(strcmp(fields(impl.Elements(k).Type),'BaseType'))
                typeInputs = [typeInputs; string(impl.Elements(k).Type.BaseType.Identifier)];
                sizeInputs = [sizeInputs; prod(impl.Elements(k).Type.Dimensions)];
            else
                typeInputs = [typeInputs; string(impl.Elements(k).Type.Identifier)];
                sizeInputs = [sizeInputs; 1];

            end
        end
    end

end
end

