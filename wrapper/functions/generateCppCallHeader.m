%% function CppScript = generateCppMappingFunction(obj, accessName)
function CppScript = generateCppCallHeader(inputObj, outputObj, save_file_path)



% Path info
save_file_path = char(save_file_path);
assert(strcmp(save_file_path(end-1:end), '.h'), "The file should be saved as a .h file");
function_saved_path = which(save_file_path);


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


% Include guard
CppScript = vertcat(CppScript, ...
    sprintf('#ifndef ZCALL_FUNCTION\n#define ZCALL_FUNCTION'));     % Memory mapping

% Includes
CppScript = vertcat(CppScript, ...
    sprintf('#include "memory_structure.h"'));     % Memory mapping

% Includes
CppScript = vertcat(CppScript, ...
    sprintf('#include <cstring>'));     % Memory mapping

% Function call, along with names. This runs on Core1 so there's no need to
% use extern and blablabla (even if it would be cool to precompile... )
% TODO: Consider separate compilation using extern.
% However, the inlcude also includes the types, so...
%% Function types
CppScript = vertcat(CppScript, ...
    sprintf('#include "%s.h"\n', inputObj.headerName));

% TODO: verify if file exists
if true
CppScript = vertcat(CppScript, ...
    sprintf('#include "%s_types.h"\n', inputObj.headerName));
end
%% Coder namespace

CppScript = vertcat(CppScript, ...
    sprintf("#ifdef __cplusplus"));

CppScript = vertcat(CppScript, ...
    sprintf("namespace coder {};"));
CppScript = vertcat(CppScript, ...
    sprintf("using namespace coder;"));
CppScript = vertcat(CppScript, ...
    sprintf("#endif"));
%% Typedef inputStructure

CppScript = vertcat(CppScript, ...
    sprintf("typedef struct inputStruct {"));

for j=1:numel(inputObj.Children)
    % Parse here the template
    CppScript = vertcat(CppScript, ...
    inputObj.Children(j).getCppDeclaration);
end

CppScript = vertcat(CppScript, ...
    sprintf("} inputStruct;\n"));



%% Typedef outputStructure

CppScript = vertcat(CppScript, ...
    sprintf("typedef struct outputStruct {"));

for j=1:numel(outputObj.Children)
    % Parse here the template
    CppScript = vertcat(CppScript, ...
    outputObj.Children(j).getCppDeclaration);
end

CppScript = vertcat(CppScript, ...
    sprintf("} outputStruct;\n"));


%% Declare callFunction();

CppScript = vertcat(CppScript, ...
    sprintf("void callFunction();"));



%% That's it!

CppScript = vertcat(CppScript, ...
    sprintf("#endif"));

%% Save file
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
