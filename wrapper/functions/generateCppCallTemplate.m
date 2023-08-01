%% function CppScript = generateCppMappingFunction(obj, accessName)
function CppScript = generateCppCallTemplate(inputObj, outputObj, save_file_path)


% Path info
save_file_path = char(save_file_path);
assert(strcmp(save_file_path(end-1:end), '.c'), "The file should be saved as a .c file");
function_saved_path = which(save_file_path);
[~,save_file_name,~] = fileparts(save_file_path);


% This should be easy. Just get the lines and the memory
% mapping from each member.
% The memory representation is parsed as-is, so the
% FULL_INPUT_STRUCTURE and the FULL_OUTPUT_STRUCTURE are
% automatically generated.

% The call template is like this
% void callFunction()
% {{set running flag}}
% p_FULLINPUTSTRUCT = (fullInputStruct*) (FULL_INPUT_STRUCT_ADDR)
% p_FULLOUTPUTSTRUCT = (fullOutputStruct*) (FULL_OUTPUT_STRUCT_ADDR)
% functionName(p_FULLINPUTSTRUCT -> input1, p_FULLINPUTSTRUCT -> input2,
% p_FULLINPUTSTRUCT -> input3, &(p_FULLOUTPUTSTRUCT -> output1`)
% // Remember to add '&' near structures (and cells?) in order
% for the structures to be passed as pointer.
% // Moreover, you should also pass the pointer to the outputs.
%

CppScript = {};

% Includes
CppScript = vertcat(CppScript, ...
    sprintf('#include "%s.h"', save_file_name));     % Memory mapping

CppScript = vertcat(CppScript, ...
    sprintf("void callFunction() {"));



% Define input structure pointer for clarity

CppScript = vertcat(CppScript, ...
    sprintf("// Define input and output struct pointer"));
CppScript = vertcat(CppScript, ...
    sprintf("inputStruct* pI = (inputStruct*) INPUTSTRUCT_BASE_ADDR;"));
CppScript = vertcat(CppScript, ...
    sprintf("outputStruct* pO = (outputStruct*) OUTPUTSTRUCT_BASE_ADDR;"));



CppScript = vertcat(CppScript, ...
    sprintf("// Call function"));
call_prototype_name = sprintf("%s(", inputObj.fcnName);
call_prototype_args = "";

full_args = [inputObj.Children, outputObj.Children];

call_prototype_args = {};
for j=1:numel(full_args)

    thisArg = {};
    % Parse here the template
    switch full_args(j).Role
        case 'input'
            thisArg = vertcat(thisArg, ...
                full_args(j).getCppArgumentForCall('pI'));
        case 'output'
            thisArg = vertcat(thisArg, ...
                full_args(j).getCppArgumentForCall('pO'));
        otherwise
            error("This should not be fed to the initializer.")
    end


    if j<numel(full_args)
        thisArg = strcat(thisArg, sprintf(", \n"));
    end

    call_prototype_args = vertcat(call_prototype_args, ...
        thisArg);
end


call_prototype_trailer = sprintf(');');

CppScript = vertcat(CppScript, ...
    call_prototype_name, ...
    call_prototype_args, ...
    call_prototype_trailer);



% Close function

CppScript = vertcat(CppScript, sprintf("\n}"));

% That's it!

%% Save to file
% Name check
% Save file
fid = fopen(save_file_path, 'w');
fprintf(fid, "%s\n", CppScript);
fclose(fid);


% Wait for save file path to exist
while not(exist(save_file_path, 'file'))
    sleep(0.1)

h = matlab.desktop.editor.openDocument(function_saved_path);
h.smartIndentContents
h.save
h.close


end