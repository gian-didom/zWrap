function base = appendCell(base,tail)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
base = horzcat(base, tail);
% if iscell(tail)
%     for k = 1:numel(tail)
%         base(end+1) = {tail{k}};
%     end
% else
%     for k = 1:numel(tail)
%         base(end+1) = {tail(k)};
%     end
% end
end