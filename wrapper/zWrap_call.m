
codegen_path = 'C:\Users\EXAMPLE_USER\zWrap\coder_build_example\codegen\lib\example_entry_function';

make_path = 'C:\Xilinx\Vitis\2023.2\gnuwin\bin';
bootgen_path = 'C:\Xilinx\Bootgen\2023.2\bin\unwrapped\win64.o';

stack = '41943040'; %'819200';
heap = '819200';

%% Calling zWrap
call_command = ['zWrap -path ', codegen_path, ' -ip 192.168.1.10 -udpport 7  -tcpport 8 -stack ', stack, ' -heap ', heap, ' -customMakePath ',  make_path, ' -customBootgenPath ',  bootgen_path];
eval(call_command)