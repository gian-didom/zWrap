function generateCEntryPoint(obj)
    fprintbf('Generating C++ entry point header and function...');
    generateCppCallTemplate(obj.project.inputs, obj.project.outputs, fullfile(obj.project.targetFolder, 'generated', 'callFunction.c'));
    generateCppCallHeader(obj.project.inputs, obj.project.outputs, fullfile(obj.project.targetFolder, 'generated', 'callFunction.h'));
    printDone();
end