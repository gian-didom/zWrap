%% function isGood = checkFunction(obj, dataRepr)
% Checks for data representation size
function isGood = checkFunction(obj, dataRepr)
isGood = numel(dataRepr) <= obj.Size;
end