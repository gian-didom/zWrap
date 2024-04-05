function [exampleOutput1, exampleOutput2] = example_entry_function(inputNumber, inputString)
% Coder build example needs at least two outputs and two connected functions
exampleOutput1 = 0;
exampleOutput2 = 0;

if ~example_aux_function(inputNumber)
    positiveInputNumber = -1 * norm(inputNumber);
exampleOutput1 = positiveInputNumber;
exampleOutput2 = length(inputString);
end

