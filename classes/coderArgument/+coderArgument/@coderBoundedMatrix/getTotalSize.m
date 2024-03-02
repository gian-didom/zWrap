%% function bytesize = getTotalSize(obj)
function bytesize = getTotalSize(obj)
    dataSize = obj.DataType.getTotalSize();
    sizeSize = obj.SizeType.getTotalSize();
    bytesize = dataSize + sizeSize;
    obj.ByteSize = bytesize;
end
