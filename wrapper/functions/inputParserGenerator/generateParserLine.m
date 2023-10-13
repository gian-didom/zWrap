function [codeLines, streamSlider] = generateParserLine(typeobj, thisArrowID, streamSlider)

if any(strcmp(fields(typeobj.Type), "Dimensions"))
    baseType = typeobj.Type.BaseType;
    fullSize = typeobj.Type.Dimensions * typeobj.Type.BaseType.WordLength/8;
else
    fullSize = typeobj.Type.WordLength/8;
end
codeLines = {sprintf("memcpy(&(INPUT_STRUCT%s), (stream+%i), %i);\n", thisArrowID, streamSlider, fullSize)};
streamSlider = streamSlider + fullSize;

end
