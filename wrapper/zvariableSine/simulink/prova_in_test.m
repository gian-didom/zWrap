function [output1 output2]  = variableSine_outputParser(byteArray)
arrayPointer = 0;


%% output1
output1 = cast(typecast(uint8(byteArray(arrayPointer+1:arrayPointer+8)), 'double'), 'double');
arrayPointer = arrayPointer + 8; arrayPointer = arrayPointer + 0;


%% output2
output2 = cast(typecast(uint8(byteArray(arrayPointer+1:arrayPointer+8)), 'double'), 'double');
arrayPointer = arrayPointer + 8; arrayPointer = arrayPointer + 0;

end
