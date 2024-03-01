
function build(obj) 

    % I/O extension
    obj.loadIOExtensions();

    % Build
    obj.generateMemoryMap();
    obj.generateCEntryPoint();

    % Run codegen extensions
    obj.loadCodegenExtensions();

end