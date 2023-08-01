function zSettings = parsezArgs(varargin)
% function zSettings = parsezArgs(varargin)
% This function parses the arguments for the configuration of the zWrap
% function. The following arguments are currently supported:
%%% Name-Value pairs
% * |ip|        - The IP address to assign to the board [192.168.1.10]
% * |udpport|   - The default port to use for UDP communication [8]
% * |tcpport|   - The default port to use for TCP communication [7]
% * |stack|     - The desired maximum stack size [-]
% * |heap|      - The desired maximum heap size [2000]
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
paramsNameValue = {'ip', 'udpport', 'tcpport', 'stack', 'heap', 'baud'};
paramsDefaultValues = {'192.168.1.10', '8', '7', 'NaN', '2000', '115200'};
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

end