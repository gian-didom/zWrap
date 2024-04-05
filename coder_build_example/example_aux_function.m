function [is_Positive] = example_aux_function(inputNumber)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
is_Positive = (norm(inputNumber) == inputNumber);
end

