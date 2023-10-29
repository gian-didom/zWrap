function zSettings = parsezArgs(varargin)
% function zSettings = parsezArgs(varargin)
% This function parses the arguments for the configuration of the zWrap
% function. The following arguments are currently supported:
%%% Name-Value pairs
% * |ip|        - The IP address to assign to the board [192.168.1.10]
% * |udpport|   - The default port to use for UDP communication [8]
% * |tcpport|   - The default port to use for TCP communication [7]
% * |stack|     - The desired maximum stack size for core1 [2 MB, 0x200000]
% * |heap|      - The desired maximum heap size for core1 [8192 bytes, 0x2000]
% * |baud|      - The default baud rate for Serial communication [115200]
%
%%% Trigger arguments
% * |limstack|  - Automatically assign stack size
% * |async|     - Enable asynchronous execution. The function does not block 
%                 until a message is received. If a message is not received, 
%                 the function returns 0.
% * |async2|    - Same as before but last value is retained.
% * |rt|        - Enable simulation pacing block
% * |unprotect| - Disable protection of generated Simulink model
% * |debug|     - Compile with debug options and flags
% * |y|         - Do not ask for overwriting
% * |no_ocm|    - Do not use on-chip memory
% * |pack|      - Use #pragma pack(1) to solve potential memory padding issues

% 
paramsNameValue = {'path', 'ip', 'udpport', 'tcpport', 'stack', 'heap', ...
                    'baud', 'customArmPath', 'customMakePath', ...
                    'customBootgenPath', 'customXilinxPath'};
paramsDefaultValues = {'none', '192.168.1.10', '8', '7', '200000', '2000', '115200', '', '', '', '', '', ''};
paramsTrigger = {'limstack', 'async', 'async2', 'rt', 'unprotect', 'debug', 'y', 'no_ocm', 'pack'};

% Initialize structure
for j=1:numel(paramsNameValue)
    fname = paramsNameValue{j};
    zSettings.(fname) = paramsDefaultValues{j};
end

for j=1:numel(paramsTrigger)
    fname = paramsTrigger{j};
    zSettings.(fname) = false;
end

% Parse inputs
isParsing = false;
for j=1:numel(varargin)
    if any(strcmp(varargin{j}(2:end), paramsNameValue))
        zSettings.(varargin{j}(2:end)) = varargin{j+1};
        isParsing = true;
    elseif any(strcmp(varargin{j}(2:end), paramsTrigger))
        zSettings.(varargin{j}(2:end)) = true; 
    else
        if isParsing
            isParsing = false;
        else
            error('Unrecognized option %s', varargin{j});
        end
    end
end

assert(isfield(zSettings, 'path'), "Path not provided. Please specify a path with the -path flag.");
assert(exist(zSettings.path, 'dir'), "The specified path <strong>%s</strong> does not exist.", zSettings.path)

% Fix stack size
if strcmp(zSettings.stack(1:2), "0x")
    zSettings.stack = hex2dec(zSettings.stack);
else
    zSettings.stack = str2double(zSettings.stack);
end


% Fix heap size
if strcmp(zSettings.heap(1:2), "0x")
    zSettings.heap = hex2dec(zSettings.heap);
else
    zSettings.heap = str2double(zSettings.heap);
end

end