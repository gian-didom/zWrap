%% function [fcn, checkFcn] = getMappingFunction(obj)
function [fcn, checkFcn] = getMappingFunction(obj)
    %METHOD1 Summary of this method goes here
    %   Detailed explanation goes here
    if (obj.hasSizeArray && not(obj.isSizeArray))
        fcn = @(x) mappingFunction(obj, x);
        return;
    end

    if (obj.isSizeArray && not(obj.hasSizeArray))
        fcn = @(x) typecast(cast(size(x), 'int32'), obj.Type);
    end

    % Check
    checkFcn = @(x) (numel(fcn(x)) == obj.Size);
end