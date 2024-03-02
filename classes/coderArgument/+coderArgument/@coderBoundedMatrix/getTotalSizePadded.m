%% function paddedSize = getTotalSizePadded(obj)
function paddedSize = getTotalSizePadded(obj)

    obj.DataType.memoryOffset = obj.memoryOffset;
    obj.DataType.Padding = -mod(obj.DataType.getTotalSizePadded(), -obj.SizeType.AlignmentRequirement);

    obj.SizeType.memoryOffset = obj.memoryOffset + obj.DataType.getTotalSizePadded() + obj.DataType.Padding;
    paddedSize = obj.DataType.getTotalSizePadded() + ...
        obj.DataType.Padding + ...
        obj.SizeType.getTotalSizePadded();
    obj.PaddedSize = paddedSize;
end