function [codeLines,streamSlider] = inputParserGenerator(codeInfo, filePath)
% parserGenerator
clc;
codeLines = cell(0,1);
streamSlider = 0;

codeLines{end+1,1} = {sprintf("void parseBuffer(void* stream) {\n")};

for j=1:numel(codeInfo.Inports)
[newLines, streamSlider] = generateParserBlock(codeInfo.Inports(1).Implementation, '', streamSlider);
codeLines = vertcat(codeLines{:}, newLines);


codeLines{end+1} = sprintf("\n};");

if nargin == 2
    fid = fopen(filePath, 'w');
    fprintf(fid, "%s\n", codeLines{:});
    fclose(fid);
    fprintf("Parser code succesfully generated.")
end
end


