%% function CppScript = generateCppMappingFunction(obj, accessName)
function CppScript = generateMemoryMap(obj, save_file_path)

    if nargin == 1
        save_file_path = fullfile(obj.project.targetFolder, 'generated', 'memorymap.h');
    end

    fprintbf('Generating memory structure mapping header...\t');


    % Path info
    save_file_path = char(save_file_path);
    assert(strcmp(save_file_path(end-1:end), '.h'), "The file should be saved as a .h file");
    function_saved_path = which(save_file_path);
    
    % Make sure padded sizes have been calculated
    obj.project.inputs.getTotalSizePadded();
    obj.project.outputs.getTotalSizePadded();
    
    % This should be easy. Just get the lines and the memory
    % mapping from each member.
    % The memory representation is parsed as-is, so the
    % FULL_INPUT_STRUCTURE and the FULL_OUTPUT_STRUCTURE are
    % automatically generated.
    
    inputStructureSize = obj.project.inputs.getTotalSizePadded();
    outputStructureSize = obj.project.outputs.getTotalSizePadded();
    
    % INCLUDE GUARDS
    CppScript = {};
    CppScript = vertcat(CppScript, ...
        sprintf("#ifndef _ZMEMORY_MAP"));
    CppScript = vertcat(CppScript, ...
        sprintf("#define _ZMEMORY_MAP\n\n"));
    
    %% Simulink define
    if strcmp(obj.project.inputs.Coder,"Simulink")
        CppScript = vertcat(CppScript, ...
        sprintf("\n#define SIMULINK\n\n"));
    end
    
    
    %% Addresses
    
    
    % INPUT STRUCTURE SIZE
    CppScript = vertcat(CppScript, ...
        sprintf("#define INPUT_STRUCT_SIZE %i", inputStructureSize));
    
    % INPUT STRUCTURE
    CppScript = vertcat(CppScript, ...
        sprintf("#define INPUTSTRUCT_BASE_ADDR (IO_BASE_ADDR)"));
    
    % OUTPUT STRUCTURE
    CppScript = vertcat(CppScript, ...
        sprintf("#define OUTPUTSTRUCT_BASE_ADDR (INPUTSTRUCT_BASE_ADDR+0x%s)", ...
        dec2hex(inputStructureSize, 8)));
    
    
    % INPUT STRUCTURE SIZE
    CppScript = vertcat(CppScript, ...
        sprintf("#define OUTPUT_STRUCT_SIZE %i", outputStructureSize));
    
    CppScript = vertcat(CppScript, ...
        sprintf("\n\n#endif // #ifdef _ZMEMORY_MAP"));
    
    
    % That's it!
    %% Save file
    fid = fopen(save_file_path, 'w');
    fprintf(fid, "%s\n", CppScript);
    fclose(fid);

    ZProject.printDone();
    
    % Wait for save file path to exist
    while not(exist(save_file_path, 'file'))
        sleep(0.1)
    
    if (desktop('-inuse'))
        h = matlab.desktop.editor.openDocument(function_saved_path);
        h.smartIndentContents;
        h.save;
        h.close
    end
    
    ZProject.printDone();

    
    end