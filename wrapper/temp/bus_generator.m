function cellInfo = bus_generator(varargin) 
% BUS_GENERATOR returns a cell array containing bus object information 
% 
% Optional Input: 'false' will suppress a call to Simulink.Bus.cellToObject 
%                 when the MATLAB file is executed. 
% The order of bus element attributes is as follows:
%   ElementName, Dimensions, DataType, Complexity, SamplingMode, DimensionsMode, Min, Max, DocUnits, Description 

suppressObject = false; 
if nargin == 1 && islogical(varargin{1}) && varargin{1} == false 
    suppressObject = true; 
elseif nargin > 1 
    error('Invalid input argument(s) encountered'); 
end 

cellInfo = { ... 
  { ... 
    'calendar', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'Value', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'coeff', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', [1 9], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'data', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'begin', 1, 'slBus66_begin', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'end', 1, 'slBus82', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'control', [1 1], 'boolean', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'thrustDirCoeffs', 1, 'slBus90_thrustDirCoeffs', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus24_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus25_epoch', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus24_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus26_origin', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus27_frame', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus28_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus29_position', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus28_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus30_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus31_velocity', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus30_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus32_stateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'origin', 1, 'slBus26_origin', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'frame', 1, 'slBus27_frame', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'position', 1, 'slBus29_position', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'velocity', 1, 'slBus31_velocity', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus33_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus34_mass', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus33_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus35_costateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'lambdaX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaM', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus36_begin', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'calendar', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'epoch', 1, 'slBus25_epoch', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'stateVector', 1, 'slBus32_stateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'mass', 1, 'slBus34_mass', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'costateVector', 1, 'slBus35_costateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus37_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus38_epoch', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus37_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus39_origin', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus40_frame', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus42_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus43_position', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus42_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus45_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus46_velocity', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus45_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus47_stateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'origin', 1, 'slBus39_origin', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'frame', 1, 'slBus40_frame', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'position', 1, 'slBus43_position', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'velocity', 1, 'slBus46_velocity', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus49_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus50_mass', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus49_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus51_costateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'lambdaX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaM', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus52', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'calendar', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'epoch', 1, 'slBus38_epoch', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'stateVector', 1, 'slBus47_stateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'mass', 1, 'slBus50_mass', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'costateVector', 1, 'slBus51_costateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus53_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus54_epoch', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus53_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus55_origin', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus56_frame', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus58_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus59_position', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus58_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus60_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus61_velocity', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus60_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus62_stateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'origin', 1, 'slBus55_origin', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'frame', 1, 'slBus56_frame', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'position', 1, 'slBus59_position', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'velocity', 1, 'slBus61_velocity', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus63_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus64_mass', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus63_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus65_costateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'lambdaX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaM', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus66_begin', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'calendar', 1, 'calendar', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'epoch', 1, 'slBus54_epoch', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'stateVector', 1, 'slBus62_stateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'mass', 1, 'slBus64_mass', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'costateVector', 1, 'slBus65_costateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus67_calendar', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'Value', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus68_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus69_epoch', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus68_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus70_origin', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus71_frame', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus72_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus73_position', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus72_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus75_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus76_velocity', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'units', 1, 'slBus75_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'X', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Y', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'Z', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus77_stateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'origin', 1, 'slBus70_origin', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'frame', 1, 'slBus71_frame', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'position', 1, 'slBus73_position', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'velocity', 1, 'slBus76_velocity', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus79_units', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus80_mass', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'value', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'units', 1, 'slBus79_units', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus81_costateVector', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'lambdaX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVX', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVY', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaVZ', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'lambdaM', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus82', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'calendar', 1, 'slBus67_calendar', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'epoch', 1, 'slBus69_epoch', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'stateVector', 1, 'slBus77_stateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'mass', 1, 'slBus80_mass', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'costateVector', 1, 'slBus81_costateVector', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus83_xUnits', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus84_yUnits', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus85_rAsc', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'xUnits', 1, 'slBus83_xUnits', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'yUnits', 1, 'slBus84_yUnits', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'order', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'coeff', 1, 'coeff', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus86_xUnits', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus87_yUnits', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', 1, 'string', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus88_coeff', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', [1 9], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus89_decl', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'xUnits', 1, 'slBus86_xUnits', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'yUnits', 1, 'slBus87_yUnits', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'order', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'coeff', 1, 'slBus88_coeff', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus90_thrustDirCoeffs', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'rAsc', 1, 'slBus85_rAsc', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'decl', 1, 'slBus89_decl', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus91_arcs', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'data', [1 300], 'data', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'size', [1 2], 'int32', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
  { ... 
    'slBus92', ... 
    '', ... 
    '', ... 
    'Auto', ... 
    '-1', ... 
    '0', {... 
{'guidConvergence', [1 1], 'double', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'begin', 1, 'slBus36_begin', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'end', 1, 'slBus52', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
{'arcs', 1, 'slBus91_arcs', 'real', 'Sample', 'Fixed', [], [], '', ''}; ...
    } ...
  } ...
}'; 

if ~suppressObject 
    % Create bus objects in the MATLAB base workspace 
    Simulink.Bus.cellToObject(cellInfo) 
end 
