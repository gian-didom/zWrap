function [codeLines, streamSlider] = generateParserBlock(typeobj, parentArrowID, streamSlider)
codeLines = cell(0,1);

if (isempty(parentArrowID))
    thisArrowID = [parentArrowID  ' -> '  typeobj.Identifier];

else
    thisArrowID = [parentArrowID  '.'  typeobj.Identifier];
end

if any(strcmp(fields(typeobj.Type), "Elements"))
    % It is composed
    for j=1:numel(typeobj.Type.Elements)
        [newLines, streamSlider] = generateParserBlock(typeobj.Type.Elements(j), thisArrowID, streamSlider);
        codeLines = {codeLines{:}; newLines{:}};
    end
else
    [codeLines, streamSlider] = generateParserLine(typeobj, thisArrowID, streamSlider);

end