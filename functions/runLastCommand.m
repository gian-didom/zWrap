function runLastCommand()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
historypath = com.mathworks.mlservices.MLCommandHistoryServices.getSessionHistory;
lastexpression = historypath(end);
eval(lastexpression)
end