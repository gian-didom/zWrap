function varargout = timingExtension(phase, varargin)


switch phase
    case 'io'
        iss = varargin{1};
        oss = varargin{2};

        % Generate dummy codeInfoObj
        codeInfoObj.Name = 'double';
        codeInfoObj.WordLength = 64;
        codeInfoObj.Identifier = 'double';

        % Add a double argument to oss
        oss.Children(end+1) = coderPrimitive(codeInfoObj);
        oss.Children(end).Role = 'output';
        oss.Children(end).Name = 'computationalTime';
        oss.Children(end).MATLABName = 'computationalTime';
        
        oss.getTotalSizePadded();
        varargout{1} = iss;
        varargout{2} = oss;

        % TODO: Add addArgument object

    case 'codegen'
        targetFolder = varargin{1};
        fileLines = split(fileread(fullfile(targetFolder, "generated", 'callFunction.c')), newline);
        % Delete lines in which the thing is called
        % First check if is the last argument. If you find anywhere this
        % called with the command, then it is NOT the last argument
        isLastArg = not(any(contains(fileLines, 'pO->computationalTime,')));
        if isLastArg
            % We must also remove the comma from the previous line
            lineNumber = find(contains(fileLines, 'pO->computationalTime'), 1);
            fileLines(lineNumber-1) = strrep(fileLines(lineNumber-1), ',','');
            % Then remove the line safely
            fileLines(contains(fileLines, 'pO->computationalTime')) = [];
        else
            % There's an argument after, no need to remove commas
            fileLines(contains(fileLines, 'pO->computationalTime')) = [];
        end

        % Add the tic()
        callFunctionLine = find(contains(fileLines, '// Call function'), 1);
        endCallFunctionLine = find(contains(fileLines, "// End of function call"), 1);
        ticLine = sprintf("    double t; \ntic(&t);");
        tocLine = "    pO->computationalTime = toc(t);";
        includeLines = {'#include "tic.h"'; 
                        '#include "toc.h"'; 
                        "extern void tic(double* t);";
                        "extern double toc(double* t);"};
        fileLines = vertcat(includeLines, ...
                        fileLines(1:callFunctionLine-1), ...
                        ticLine, ...
                        fileLines(callFunctionLine:endCallFunctionLine), ...
                        tocLine, ...
                        fileLines(endCallFunctionLine+1:end));

        fid = fopen(fullfile(targetFolder, "generated", 'callFunction.c'), 'w');
        fprintf(fid, "%s\n", fileLines);
        fclose(fid);

        % Wait for save file path to exist
        pause(1);
        function_saved_path = which(fullfile(targetFolder, "generated", 'callFunction.c'));

        h = matlab.desktop.editor.openDocument(function_saved_path);
        h.smartIndentContents
        h.save
        h.close
        

    otherwise
        % Do nothing;
end