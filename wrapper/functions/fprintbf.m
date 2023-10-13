function [outputArg1,outputArg2] = fprintbf(varargin)
%UNTITLED14 Summary of this function goes here
%   Detailed explanation goes here
global lastLine;
fprintf('<strong>');
fprintf(varargin{:});
fprintf('</strong>');

lastLine = varargin{:};
end