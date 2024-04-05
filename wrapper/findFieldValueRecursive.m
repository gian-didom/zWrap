function value = findFieldValueRecursive(s, fieldName)
    % Check if the field exists in the struct
    if isfield(s, fieldName)
        % If the field is found, return its value
        value = s.(fieldName);
    else
        % If the field is not found, recursively search through the struct's fields
        fields = fieldnames(s);
        for i = 1:numel(fields)
            value = findFieldValueRecursive(s.(fields{i}), fieldName);
            if ~isempty(value)
                return;
            end
        end
        % If the field is not found in any nested structs, return empty
        value = [];
    end
end