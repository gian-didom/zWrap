function byteArray = variableSine_inputSerializer(input1, input2)
byteArray = uint8(zeros(16, 1));


%% input1
byteArray(1:8) = typecast(cast(input1, 'double'), 'uint8');


%% input2
byteArray(9:16) = typecast(cast(input2, 'double'), 'uint8');

end
