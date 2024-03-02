%% function MATLABScript = generateMATLABFunction(obj, accessName)
function functionScript = generateMATLABFunction(obj, accessName, nestLevel)
% The accessName is given from the parent
if nargin == 2; nestLevel = 1; end

arrayName = strcat(generateRandomString(), '_vmat');
% Initialize array
functionScript = {sprintf("\n%s = uint8(zeros(%i, 1));", arrayName, obj.PaddedSize)};

if isa(obj.DataType.BaseType, "coderPrimitive")
    % We can typecast directly
    functionScript = vertcat(functionScript, ...
        sprintf("%s(%i:%i+numel(%s)*%i) = typecast(cast(%s(:), '%s'), 'uint8');", ...
        arrayName, 1, 0,accessName, obj.DataType.BaseType.ByteSize, ...
        accessName, obj.DataType.BaseType.MATLABCastType));
    
    
    functionScript = vertcat(functionScript, ...
        sprintf("%s_size = ones(1,%i);", arrayName, obj.SizeType.Dimension));
    
    functionScript = vertcat(functionScript, ...
        sprintf("%s_size(1:numel(size(%s))) = size(%s).';", ...
        arrayName, accessName, accessName));
    
    
    functionScript = vertcat(functionScript, ...
        sprintf("%s(%i:%i) = typecast(cast(%s_size, '%s'), 'uint8');", ...
        arrayName, ...
        obj.DataType.PaddedSize+1+obj.DataType.Padding, ...
        obj.DataType.PaddedSize+obj.DataType.Padding+obj.SizeType.PaddedSize, ...
        arrayName, obj.SizeType.BaseType.MATLABCastType));
    
    functionScript = vertcat(functionScript, ...
        sprintf("byteArray(%i:%i) = %s;\n", ...
        obj.DataType.memoryOffset+1, ...
        obj.DataType.memoryOffset+obj.PaddedSize, arrayName));
    
else
    % We need to instantiate a for-loop
    
    indexLoop = repmat('j', 1, nestLevel);
    
    % Now we must fill the first part (obj.DataType.PaddedSize)
    % with the data coming from each BaseType object.
    % To do this, we must iterate over the indexes.
    % This matrix is fixed BUT it doesn't mean anything since
    % fixed matrices are also inside variable matrices - bof...
    functionScript = vertcat(functionScript, ...
        sprintf("for %s=1:numel(%s)", indexLoop, accessName));
    
    % Generate lines for Base Type
    outlines = obj.DataType.BaseType.generateMATLABFunction( ...
        sprintf("%s(%s)", accessName, indexLoop), nestLevel+1 ...
        );
    
    % Replace all the byteArray assignments with the
    % assignments on the localArray. Then, we will index the
    % localArray into the ByteArray. This is good to avoid
    % issue with memory indexes
    for j=1:numel(outlines)
        sides = split(outlines(j), ' = ');
        if numel(sides) > numel(outlines(j)) && startsWith(sides{1}, 'byteArray')
            rhs = sides{2};
            rhs_uncomm = split(rhs, ';');
            outlines(j) = sprintf("%s((%s-1)*%i+1:%s*%i) = %s; %s", ...
                arrayName, indexLoop, obj.DataType.BaseType.PaddedSize, ...
                indexLoop, obj.DataType.BaseType.PaddedSize, ...
                rhs_uncomm{1}, rhs_uncomm{2});
        end
        outlines(j) = strcat(sprintf("\t"), outlines(j));
        % There is no data padding between array elements.
        functionScript = vertcat(functionScript, outlines(j));
        
    end
    functionScript = vertcat(functionScript, sprintf("end"));
    
    
    
    
    functionScript = vertcat(functionScript, ...
        sprintf("%s_size = ones(1,%i);", ...
        arrayName, obj.SizeType.Dimension));
    
    functionScript = vertcat(functionScript, ...
        sprintf("%s_size(1:numel(size(%s))) = size(%s).';", ...
        arrayName, accessName, accessName));
    
    
    functionScript = vertcat(functionScript, ...
        sprintf("%s(%i:%i) = typecast(cast(%s_size, '%s'), 'uint8');", ...
        arrayName, obj.DataType.PaddedSize+1, obj.DataType.PaddedSize+obj.SizeType.ByteSize, ...
        arrayName, obj.SizeType.BaseType.MATLABCastType));
    
    
    functionScript = vertcat(functionScript, sprintf("byteArray(%i:%i+numel(%s)) = %s; %%%i\n", ...
        obj.memoryOffset+1, obj.memoryOffset, arrayName, arrayName, obj.memoryOffset+obj.ByteSize));
    
    
end

end