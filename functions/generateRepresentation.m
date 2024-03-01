function [outputArg1,outputArg2] = generateRepresentation(EntryPoints,varargin)
%UNTITLED3 Summary of this function goes here

assert(numel(EntryPoints.InputTypes) == numel(varargin), 'The number of inputs is different from what requested from the entry-point function');
% Then assert that each type corresponds.
getbyteArray()
end

function byteArray = getbyteArray(inputType, coderType)

assert(isa(inputType, coderType.class), sprintf("The input type class <strong>%s</strong> does not correspond to the expected type class <strong>%s</strong>", class(inputType), coderType.class));

% Size assertrawion
sizeIn = size(inputType);
sizeCoder = coderType.SizeVector;

if any(inputType.VariableDims)
    % Check bounds
    assert(all(sizeIn(coderType.VariableDims) <= coderType.SizeVector(coderType.VariableDims)), ...
        "Input sizes do not correspond.");
end

if any(not(inputType.VariableDims))
    % Check exact size
    assert(all(sizeIn(not(coderType.VariableDims)) == coderType.SizeVector(not(coderType.VariableDims))));
end

% Initialize raw bytes
byteArray = uint8([]);
switch class(coderType)
    case 'coder.StructType'
        if isprop(coderType, 'Fields') && numel(coderType.Fields) > 0
            allFields = coderType.Fields;
            % Recurse
            for j=1:numel(fields(coderType.Fields))
               fname = allFields{j};
               byteArray = horzcat(byteArray, getbyteArray(inputType.(fname), coderType.Fields.(fname)));
            end
        else
            warning("Empty structure?")
        end

    case 'coder.PrimitiveType'

        byteArray = typecast(cast(inputType(:), coderType.ClassName), 'uint8');
        if any(coderType.VariableDims)
            byteArray = horzcat(byteArray, typecast(size(inputType), 'uint8'));
        end
end


end