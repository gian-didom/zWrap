function outpath = generateSimulinkLibrary(iss, oss, savepath)
global zSettings



maskCommandRun = "blockpos = get_param(gcb, 'Position'); block_w = blockpos(3)-blockpos(1); block_h = blockpos(4)-blockpos(2); image('support/run.png',[block_w/2-30, block_h/2-8, 60,16]);";
maskCommandInput = "blockpos = get_param(gcb, 'Position'); block_w = blockpos(3)-blockpos(1); block_h = blockpos(4)-blockpos(2); image('support/serialize.svg',[block_w/2-20, block_h/2-20, 40,40]);";
maskCommandOutput = "blockpos = get_param(gcb, 'Position'); block_w = blockpos(3)-blockpos(1); block_h = blockpos(4)-blockpos(2); image('support/parse.svg',[block_w/2-20, block_h/2-20, 40,40]);";
% Initialize Simulink model

modelname = iss.fcnName;
close_system(modelname, 0);
bdclose(modelname);
new_system(modelname, 'Library');

%% Create data buses
% To do that, we must get the MATLAB templates for the I/O

args_struct = {};

for j=1:numel(iss.Children)
    arg = iss.Children(j).getTemplate();
    if isstruct(arg)
        args_struct{end+1} = arg;
        Simulink.Bus.createObject(arg);
    end
end

%% Add subsystem
subsystem_path = sprintf('%s/%s', modelname, modelname);
add_block('simulink/Ports & Subsystems/Subsystem', subsystem_path);
% Also delete default connection for subsystem
delete_line(subsystem_path, 'In1/1', 'Out1/1');
delete_block(sprintf('%s/In1', subsystem_path));
delete_block(sprintf('%s/Out1', subsystem_path));

%% Add input parser
add_block('simulink/User-Defined Functions/MATLAB Function', sprintf('%s/inputSerializer', subsystem_path));
config = get_param(sprintf("%s/inputSerializer", subsystem_path), 'MATLABFunctionConfiguration');
config.FunctionScript = fileread(sprintf('z%s/simulink/%s_inputSerializer.m', iss.fcnName, iss.fcnName));
% Add mask
inputMask = Simulink.Mask.create(sprintf('%s/inputSerializer', subsystem_path));
inputMask.IconUnits = 'pixels';
inputMask.Display = maskCommandInput;
inputMask.SaveImageFileWithModel = 'on';



%% Add output parser

add_block('simulink/User-Defined Functions/MATLAB Function', sprintf('%s/outputParser', subsystem_path));
config = get_param(sprintf("%s/outputParser", subsystem_path), 'MATLABFunctionConfiguration');
config.FunctionScript = fileread(sprintf('z%s/simulink/%s_outputParser.m', iss.fcnName, iss.fcnName));
% Add mask

% Set output size - because Simulink is really stupid
stateflowBlock = find(get_param(subsystem_path,"Object"), '-isa', 'Stateflow.EMChart', 'Path', sprintf('%s/outputParser', subsystem_path));
for j=1:numel(oss.Children)
    dims = size(oss.Children(j).getTemplate());
    stateflowBlock.Outputs(j).Props.Array.Size = strcat("[", sprintf('%i ', dims), "]");
end
outputMask = Simulink.Mask.create(sprintf('%s/outputParser', subsystem_path));
outputMask.IconUnits = 'pixels';
outputMask.Display = maskCommandOutput;
outputMask.SaveImageFileWithModel = 'on';

% Set number of output ports
% set_param('%s/outputParser', 'num')
%% Add input ports
for j=1:numel(iss.Children)
    add_block('simulink/Sources/In1', sprintf('%s/in_%s', subsystem_path, iss.Children(j).MATLABName));
    add_line(subsystem_path, sprintf('in_%s/1', iss.Children(j).MATLABName), sprintf('inputSerializer/%i', j));
end

%% Add output ports
for j=1:numel(oss.Children)
    add_block('simulink/Sinks/Out1', sprintf('%s/out_%s', subsystem_path, oss.Children(j).MATLABName));
    add_line(subsystem_path, sprintf('outputParser/%i', j), sprintf('out_%s/1', oss.Children(j).MATLABName));
    % set_param(sprintf('%s/%s/1', oss.Children(j).MATLABName, j), 'PortDimensions', [2 3]);
end


%% Add UDP "run" block
add_block('instrumentlib/UDP Send', sprintf('%s/UDP Send', subsystem_path));
add_block('simulink/Sources/Constant', sprintf('%s/Run Command', subsystem_path));
set_param(sprintf("%s/Run Command", subsystem_path), "Value", "uint8(sprintf('run\n'))");
add_line(subsystem_path, "Run Command/1", "UDP Send/1");
set_param(sprintf("%s/UDP Send", subsystem_path), 'Host', zSettings.ip);
set_param(sprintf("%s/UDP Send", subsystem_path), 'Port', zSettings.udpport);
set_param(sprintf("%s/UDP Send", subsystem_path), 'AttributesFormatString', "%<Host>:%<Port>");
set_param(sprintf("%s/UDP Send", subsystem_path), 'Priority', "0");
% Add mask
runMask = Simulink.Mask.create(sprintf('%s/Run Command', subsystem_path));
runMask.IconUnits = 'pixels';
runMask.Display = maskCommandRun;
runMask.SaveImageFileWithModel = 'on';

%% Add TCP input send block
add_block('instrumentlib/TCP//IP Send', sprintf('%s/TCP Send', subsystem_path));
add_line(subsystem_path, "inputSerializer/1", "TCP Send/1");
set_param(sprintf("%s/TCP Send", subsystem_path), 'Host', zSettings.ip);
set_param(sprintf("%s/TCP Send", subsystem_path), 'Port', zSettings.tcpport);
set_param(sprintf("%s/TCP Send", subsystem_path), 'AttributesFormatString', "%<Host>:%<Port>");
set_param(sprintf("%s/TCP Send", subsystem_path), 'Priority', "1");

%% Add TCP input receive block
add_block('instrumentlib/TCP//IP Receive', sprintf('%s/TCP Receive', subsystem_path));
add_line(subsystem_path, "TCP Receive/1", "outputParser/1");
set_param(sprintf("%s/TCP Receive", subsystem_path), 'Host', zSettings.ip);
set_param(sprintf("%s/TCP Receive", subsystem_path), 'Port', zSettings.tcpport);
set_param(sprintf("%s/TCP Receive", subsystem_path), 'DataSize', num2str(oss.getTotalSizePadded));
set_param(sprintf("%s/TCP Receive", subsystem_path), 'AttributesFormatString', "%<Host>:%<Port>");
set_param(sprintf("%s/TCP Receive", subsystem_path), 'Priority', "2");

if zSettings.async || zSettings.async2
    set_param(sprintf("%s/TCP Receive", subsystem_path), 'EnableBlockingMode', 'off');
    % TODO: Add conditions and blocks for async2 - retaning the old values.
else
    set_param(sprintf("%s/TCP Receive", subsystem_path), 'Timeout', '1e10');
    set_param(sprintf("%s/TCP Receive", subsystem_path), 'SampleTime', '-1');

end
%% Add graphics, images, etc
% Arrow image
arrowMatrix_path = fullfile('support', 'arrow.png');
aphoto = Simulink.Annotation(subsystem_path,'This is an annotation.');
setImage(aphoto, arrowMatrix_path);
setImage(aphoto, arrowMatrix_path); aphoto_AR = (aphoto.Position(3) - aphoto.Position(1)) / (aphoto.Position(4) - aphoto.Position(2));
aphoto.FixedHeight = 'on';
aphoto.FixedWidth = 'on';

% Board image
zMatrix_path = fullfile('support', 'zedboard.png');
zphoto = Simulink.Annotation(subsystem_path,'This is an annotation.');
setImage(zphoto, zMatrix_path);
zphoto.FixedHeight = 'on';
zphoto.FixedWidth = 'on';


%% Add mask to subsystem
% WIP

%% Arrange
Simulink.BlockDiagram.arrangeSystem(subsystem_path);

% Arrange position of main skeleton
pos_udp = get_param(sprintf('%s/UDP Send', subsystem_path), 'Position');
set_param(sprintf('%s/UDP Send', subsystem_path), 'Position', [212 37 342 37+40]);

set_param(sprintf('%s/Run Command', subsystem_path), 'Position', [0 40 100 70]);

pos_tcp_send = get_param(sprintf('%s/TCP Send', subsystem_path), 'Position');
pos_tcp_send(1) = 212;
pos_tcp_send(2) = 137;
pos_tcp_send(3) = 342;
pos_tcp_send(4) = 137 + max(40, 20*numel(iss.Children));
set_param(sprintf('%s/TCP Send', subsystem_path), 'Position', pos_tcp_send);

pos_tcp_receive = get_param(sprintf('%s/TCP Receive',subsystem_path), 'Position');
pos_tcp_receive(1) = 212;
pos_tcp_receive(2) = pos_tcp_send(4) + 60;
pos_tcp_receive(3) = 342;
pos_tcp_receive(4) = pos_tcp_send(4) + 100;
set_param(sprintf('%s/TCP Receive', subsystem_path), 'Position', pos_tcp_receive);

pos_input_parser = get_param(sprintf('%s/inputSerializer', subsystem_path), 'Position');
pos_input_parser(1) = 85;
pos_input_parser(2) = pos_tcp_send(2);
pos_input_parser(3) = 125;
pos_input_parser(4) = pos_input_parser(2) + max(40, 20*numel(iss.Children));
set_param(sprintf('%s/inputSerializer', subsystem_path), 'Position', pos_input_parser);

for j=1:numel(iss.Children)
    in_pos = get_param(sprintf('%s/in_%s', subsystem_path, iss.Children(j).MATLABName), 'Position');
    in_pos(1) = -80;
    if numel(iss.Children) == 1
        in_pos(2) = pos_tcp_send(2) + (j)*20 - 10;
    else
        in_pos(2) = pos_tcp_send(2) + (j-1)*20;
    end
    in_pos(3) = -50;
    in_pos(4) = in_pos(2) + 14;
    set_param(sprintf('%s/in_%s', subsystem_path, iss.Children(j).MATLABName), 'Position', in_pos);

end


for j=1:numel(oss.Children)
    out_pos = get_param(sprintf('%s/out_%s', subsystem_path, oss.Children(j).MATLABName), 'Position');
    out_pos(1) = 547;

    if numel(oss.Children) == 1
        out_pos(2) = pos_tcp_receive(2) + (j)*20 - 10;
    else
        out_pos(2) = pos_tcp_receive(2) + (j-1)*20;
    end

    out_pos(3) = 577;
    out_pos(4) = out_pos(2) + 14;
    set_param(sprintf('%s/out_%s', subsystem_path, oss.Children(j).MATLABName), 'Position', out_pos);

end

aphoto.Position = [262, pos_udp(2)-20, 292, pos_tcp_receive(2)];


pos_output_parser = get_param(sprintf('%s/outputParser', subsystem_path), 'Position');
pos_output_parser(1) = 405;
pos_output_parser(2) = pos_tcp_receive(2);
pos_output_parser(3) = 445;
pos_output_parser(4) = pos_output_parser(2) + max(40, 20*numel(oss.Children));
set_param(sprintf('%s/outputParser', subsystem_path), 'Position', pos_output_parser);

zphoto.Position(1) = pos_output_parser(1);
zphoto.Position(2) = pos_output_parser(2)-200;
zphoto.Position(3:4) = zphoto.Position(1:2) + [40 35]*3.5;



%% Save library
save_system(modelname, savepath);
end