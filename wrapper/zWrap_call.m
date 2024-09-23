
codegen_path = 'C:\Users\EXAMPLE_USER\zWrap\coder_build_example\codegen\lib\example_entry_function';

% custom_make_path = 'C:\Xilinx\Vitis\2023.2\gnuwin\bin';

stack = '41943040'; %'819200';
heap = '819200';

%% Calling zWrap
% call_command = ['zWrap -path ', codegen_path, ' -ip 192.168.1.10 -udpport 7  -tcpport 8 -stack ', stack, ' -heap ', heap, ' -customMakePath ',  custom_make_path];
call_command = ['zWrap -path ', codegen_path, ' -ip 192.168.1.10 -udpport 7  -tcpport 8 -stack ', stack, ' -heap ', heap];
eval(call_command)