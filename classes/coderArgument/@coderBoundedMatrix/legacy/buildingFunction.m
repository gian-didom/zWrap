%% function outputVariable = buildingFunction(obj, inputStream, varargin)
function outputVariable = buildingFunction(obj, inputStream, varargin)

    if (obj.hasSizeArray && not(obj.isSizeArray))
        if numel(varargin)<1 || not(varargin{1}.isSizeArray)
            error("This building needs to have the size object");

        end
        sizeArray = varargin{1};
        streamPointer = 1;

        % Is data array - should cast.
        % Then we must find the size
        sizeStreamPointer = streamPointer + obj.PaddedSize;
        arraySize = typecast(inputStream(sizeStreamPointer:sizeArray.Size+sizeStreamPointer-1), sizeArray.MATLABType);
        arraySize = reshape(arraySize, 1, []);

        typeSize = obj.SizeBytes/ obj.NumEl;
        endPointerLocation = prod(arraySize)*typeSize;
        arrayData = typecast(inputStream(1:endPointerLocation), obj.MATLABType);
        outputVariable = reshape(arrayData, arraySize);


    elseif (obj.isSizeArray && not(obj.hasSizeArray))
        % Is size array - ignore.
        error("We should not be here.");
    else

        castedArray = typecast(inputStream(1:obj.Size), obj.MATLABType);
        outputVariable = reshape(castedArray, obj.Dimension);
    end
end