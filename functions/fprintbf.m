function [outputArg1,outputArg2] = fprintbf(varargin)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
global lastLine;
if (desktop('-inuse'))
    fprintf('<strong>');
    fprintf(varargin{:});
    fprintf('</strong>');
else
    % Use terminal tags for bold
    fprintf('\033[1m');
    fprintf(varargin{:});
    fprintf('\033[0m');
end

lastLine = varargin{:};
end