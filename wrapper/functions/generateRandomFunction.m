function [outputArg1,outputArg2] = generateRandomFunction()
% GENERATERANDOMFUNCTION This function generates a random MATLAB function.
% The randomness is in the type and size of the input, as well as in the
% fact that the arguments are either fixed or variable size.
% The function also supports nested arguments - i.e., nested structures.
% Currently, support for random classes is not provided (but is feasible
% for future implementations).
% The function is built this way:
% - The input arguments type and size and randomically generated
% - A folder with a MATLAB function is generated. The MATLAB function
%   contains a set of assert statement that - upon code generation - will
%   set the type and size of the corresponding input port.
% - Output size and type are initialized in the MATLAB function so that the
%   coder automatically infer their size and type.

fcnSettings.allowedTypes = {'struct', 'matrix', 'cell', 'primitive'}; % TODO: Add string
fcnSettings.allowedPrimitives = {'single', 'int32', 'int64', 'logical', 'char', 'double'};

fcnSettings.maxInputs = 10; % Max number of inputs
fcnSettings.maxNesting = 4; % Max number of nesting
fcnSettings.maxFields = 10; % Max number of nesting
fcnSettings.maxMatrixElements = 100^3; % Max number of elements in a single array
fcnSettings.maxNestedArrayElements = 100; % Max number of nested elements (i.e., struct) in a single array
fcnSettings.maxDimensions = 5; % Max number of dimensions for an array

%% Part 1: how many inputs?
numInputs = randi(fcnSettings.maxInputs);

%% Part 2: which input type?
inputTypes = fcnSettings.allowedTypes(randi(numel(fcnSettings.allowedTypes), [numInputs 1]));
inputNames = {};
%% Part 3: generate input
fullOutputCells = {};
fullDeclarationCells = {};
for j=1:numInputs
    inputName = generateRandomString(); inputNames{j} = inputName;
    [outInputCells, outDeclarationCells] = generateRandomInput(inputTypes{j}, fcnSettings, inputName, fcnSettings.maxNesting);
    fullOutputCells = vertcat(fullOutputCells, outInputCells);
    fullDeclarationCells = vertcat(fullDeclarationCells, outDeclarationCells);
end

%% Part 4: Generate function header and tail
fcnName = sprintf("%s_fun", generateRandomString());

fullOutputCells = vertcat(sprintf("function %s(%s)", fcnName, strjoin(inputNames, ',')), ...
    fullOutputCells, ...
    "end");

%% Part 5: Save file
mkdir(fullfile("test", fcnName));
fid = fopen(fullfile("test", fcnName, sprintf("%s.m", fcnName)), 'w');
fprintf(fid, "%s\n", strrep(fullOutputCells, sprintf(',\b'), ''));

%% Part 6: generate call template
fullDeclarationCells = vertcat(fullDeclarationCells, ...
    sprintf("%s(%s);\n", fcnName , strjoin(inputNames, ',')));


fullDeclarationCells = vertcat(fullDeclarationCells, ...
    sprintf("codegen %s -args {%s}\n", fcnName , strjoin(inputNames, ',')));

fid = fopen(fullfile("test", fcnName, sprintf("%s_call.m", fcnName)), 'w');
fprintf(fid, "%s\n", strrep(fullDeclarationCells, sprintf(',\b'), ''));


end

function [outCell, outDeclaration] = generateRandomInput(type, fcnSettings, inputName, nestLevel)
if nargin == 4
    nestLevel = 1;
end
switch type

    case 'struct'

        numDims = 1+randi(fcnSettings.maxDimensions-1);
        % Random size while keeping elements <  maxNestedArrayElements
        numElements = floor(rand(1,1) * fcnSettings.maxNestedArrayElements);
        randCoeffs = rand(1, numDims);
        matSize = max(1, floor(numElements.^(randCoeffs./sum(randCoeffs))));
        numElements = prod(matSize);


        outCell = {sprintf("assert(isa(%s, 'struct'));", inputName)};
        outDeclaration = {};
        variableDimensions = (rand(1, numDims) > 0.5);

        for j=1:numDims
            % Sign for comparison depends on wether it's variable-sized
            if variableDimensions(j); relSign = "<="; else; relSign = "=="; end

            % Generate assert statement
            outCell = vertcat(outCell, ...
                sprintf("assert(size(%s, %i) %s %i);", inputName, ...
                j, relSign, matSize(j)));
        end

        % Do the same for each fields.
        numFields = randi(fcnSettings.maxFields);

        for j=1:numFields
            fieldName = generateRandomString();
            fieldType = fcnSettings.allowedTypes{randi(numel(fcnSettings.allowedTypes))};
            while nestLevel <= 1 && (strcmp(fieldType, "struct") || strcmp(fieldType, "cell"))
                fieldType = fcnSettings.allowedTypes{randi(numel(fcnSettings.allowedTypes))};
            end
            [fieldOutCell, fieldOutDeclaration] = generateRandomInput(fieldType, fcnSettings, sprintf("%s(1).%s", inputName, fieldName), nestLevel-1);
            outCell = vertcat(outCell, fieldOutCell);
            outDeclaration = vertcat(outDeclaration, fieldOutDeclaration);
        end

        outDeclaration = vertcat(outDeclaration, sprintf("%s = repmat(%s(1), %s\b);", ...
            inputName, inputName, ...
            sprintf("%i,", matSize)));

    case 'matrix'

        numDims = 1+randi(fcnSettings.maxDimensions-1);
        primitiveType = fcnSettings.allowedPrimitives{randi(numel(fcnSettings.allowedPrimitives))};

        % Random size while keeping elements <  maxMatrixElements
        numElements = floor(rand(1,1) * fcnSettings.maxMatrixElements);
        randCoeffs = rand(1, numDims);
        matSize = max(1, floor(numElements.^(randCoeffs./sum(randCoeffs))));
        numElements = prod(matSize);

        variableDimensions = rand(1, numDims) > 0.5;

        outCell = {sprintf("assert(isa(%s, '%s'));", inputName, primitiveType)};
        for j=1:numDims
            % Sign for comparison depends on wether it's variable-sized
            if variableDimensions(j); relSign = "<="; else; relSign = "=="; end

            % Generate assert statement
            outCell = vertcat(outCell, ...
                sprintf("assert(size(%s, %i) %s %i);", inputName, ...
                j, relSign, matSize(j)));
        end

        outDeclaration = sprintf("%s = %s(zeros(%s\b));", ...
            inputName, primitiveType, sprintf("%i,", matSize));




    case 'cell'

        isHeterogeneous = rand(1,1) > 0.5;
        if isHeterogeneous
            % Heterogeneous cell; we must specify the fact that is a cell,
            % and the size and element type. Variable size is permitted.
            numDims = 1+randi(fcnSettings.maxDimensions-1);
            % Random size while keeping elements <  maxNestedArrayElements
            numElements = floor(rand(1,1) * fcnSettings.maxNestedArrayElements);
            randCoeffs = rand(1, numDims);
            matSize = max(1, floor(numElements.^(randCoeffs./sum(randCoeffs))));
            numElements = prod(matSize);

            outCell = {sprintf("assert(isa(%s, 'cell'));", inputName)};
            for j=1:numDims
                % Sign for comparison depends on wether it's variable-sized

                % Generate assert statement
                outCell = vertcat(outCell, ...
                    sprintf("assert(size(%s, %i) == %i);", inputName, ...
                    j, matSize(j)));
            end

            outDeclaration = sprintf("%s = cell(%s\b);", inputName, ...
                sprintf("%i,", matSize));


            % Do the same for each fields.
            for j=1:numElements

                cellContentName = generateRandomString();
                cellContentType = fcnSettings.allowedTypes{randi(numel(fcnSettings.allowedTypes))};
                while nestLevel <= 1 && (strcmp(cellContentType, "struct") || strcmp(cellContentType, "cell"))
                    cellContentType = fcnSettings.allowedTypes{randi(numel(fcnSettings.allowedTypes))};
                end
                outCell = vertcat(outCell, sprintf("%s = %s{%i};", cellContentName, inputName, j));
                [cellcontentOutCell, cellContentDeclaration] = generateRandomInput(cellContentType, fcnSettings, cellContentName, nestLevel-1);
                outCell = vertcat(outCell, cellcontentOutCell);
                outDeclaration = vertcat(outDeclaration, cellContentDeclaration);

                outDeclaration = vertcat(outDeclaration, sprintf("%s{%i} = %s;", inputName, j, cellContentName));
            end
        else
            % Non-heterogeneous cell; we must specify the fact that is a cell,
            % and the size. Variable size is permitted.
            numDims = 1+randi(fcnSettings.maxDimensions-1);
            % Random size while keeping elements <  maxNestedArrayElements
            numElements = floor(rand(1,1) * fcnSettings.maxNestedArrayElements);
            randCoeffs = rand(1, numDims);
            matSize = max(1, floor(numElements.^(randCoeffs./sum(randCoeffs))));
            numElements = prod(matSize);

            outCell = {sprintf("assert(isa(%s, 'cell'));", inputName)};
            variableDimensions = rand(1, numDims) > 0.5;


            outDeclaration = sprintf("%s = cell(%s\b);", inputName, ...
                sprintf("%i,", matSize));

            for j=1:numDims
                % Sign for comparison depends on wether it's variable-sized
                if variableDimensions(j); relSign = "<="; else; relSign = "=="; end

                % Generate assert statement
                outCell = vertcat(outCell, ...
                    sprintf("assert(size(%s, %i) %s %i);", inputName, ...
                    j, relSign, matSize(j)));
            end


            outDeclaration = sprintf("%s = cell(%s\b);", inputName, ...
                sprintf("%i,", matSize));
            % Do the same for each fields.

            cellContentName = generateRandomString();
            cellContentType = fcnSettings.allowedTypes{randi(numel(fcnSettings.allowedTypes))};
            while nestLevel <= 1 && (strcmp(cellContentType, "struct") || strcmp(cellContentType, "cell"))
                cellContentType = fcnSettings.allowedTypes{randi(numel(fcnSettings.allowedTypes))};
            end
            outCell = vertcat(outCell, sprintf("%s = %s{1};", cellContentName, inputName));
            [cellcontentOutCell, cellContentDeclaration] = generateRandomInput(cellContentType, fcnSettings, cellContentName, nestLevel-1);
            outCell = vertcat(outCell, cellcontentOutCell);
            outDeclaration = vertcat(outDeclaration, cellContentDeclaration);
            outDeclaration = vertcat(outDeclaration, ...
                sprintf("%s = cellfun(@(x) %s, %s, 'UniformOutput', false);", inputName, cellContentName, inputName));



        end
    case 'string'

    case 'primitive'
        primitiveType = fcnSettings.allowedPrimitives{randi(numel(fcnSettings.allowedPrimitives))};
        outCell = {sprintf("assert(isa(%s, '%s'));", inputName, primitiveType)};
        % Generate assert statement
        outCell = vertcat(outCell, sprintf("assert(all(size(%s) == 1));", inputName));
        outDeclaration = sprintf("%s = %s(0);", inputName, primitiveType);

end

end