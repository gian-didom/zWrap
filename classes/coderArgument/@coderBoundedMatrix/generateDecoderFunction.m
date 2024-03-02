%% class **CoderBoundedMatrix**
% *CoderBoundedMatrix* is a class that represents a matrix with bounded dimensions.
% The matrix is defined by a *DataType* and a *SizeType*.
% The *DataType* defines the type of the elements of the matrix, while the *SizeType* defines the type of the size of the matrix.
%% function generateDecoderFunction(obj, accessName, nestLevel)
%
% The *generateDecoderFunction* method generates a MATLAB function that decodes the matrix from a byteArray. The information on the size are hardcoded in the function according to the structure returned in the codeInfo.mat object.
% The output string is appended to the overall decoder function for the specific application.
%
%%%% Functional description
% A coderBoundedMatrix object is normally characterized by a |<name>_data| variable and a |<name>_size| one. The first thing to do is to typecast the |_size| object in order to understand the dimensions of the matrix as returned by the function.
%
% Once this information has been retrieved, according to the type of data contained in the matrix, different operations are performed.
%
% ** Primitive matrices **
% In case of primitive matrices, the entire byte array is typecasted to the primitive data type. The resulting vector is then reshaped according to the data_size object and assigned to the output variable. The resulting matrix - when smalled than the specified max size - is padded with zeros.
%
% ** Non-primitive matrices **
% In this case, the casting is not trivial and is automatically delegated to the Children BaseType associated object. Before doing that, a for-loop is instantiated to iterate over the maximum number of elements in the matrix. We do not loop on the effective size because the matrix should be padded anyway with zeros; however, we check if the index is smaller than the actual size and assign the value to the output matrix, otherwise no action is performed.
% In order to manage the variable naming, a random string is generated and passed to the children object. The children object will return the name of the variable that has been used to store the result of the decoding. This name is then used to assign the value to the output matrix.
%
%% ==============================================================================================

%% function functionScript = generateDecoderFunction(obj, accessName)
function functionScript = generateDecoderFunction(obj, accessName, nestLevel)

% Input guard
if nargin == 2; nestLevel = 1; end

% Initialize array name and empty function script. % The accessName is given by the parent.
arrayName = strcat(generateRandomString(), '_mat');
functionScript = {};

% Get size for reshaping
functionScript = vertcat(functionScript, ...
    sprintf("%s_size = reshape(typecast(byteArray(arrayPointer + %i+1:arrayPointer+%i+%i), '%s'), 1, []);", ...
    arrayName, ...                                      % Array name
    obj.DataType.PaddedSize + obj.DataType.Padding, ... % Bytearray total size
    obj.DataType.PaddedSize + obj.DataType.Padding, ... % Bytearray total size
    obj.SizeType.PaddedSize, ...                        % Size type size
    obj.SizeType.BaseType.MATLABCastType));             % Base type size

%%%% HANDLE MATRIX DECODING
if isa(obj.BaseType, "coderPrimitive")  % PRIMITIVE TYPES
    % In this case, we only needƒ to typecast the entire matrix. No need for the size.
    
    % Cast byteArray into local array.
    functionScript = vertcat(functionScript, ...
        sprintf("%s = cast(typecast(byteArray(arrayPointer+1:arrayPointer+%i*prod(%s_size)), '%s'),'%s');", ...
        arrayName, ...                                  % Array name
        obj.DataType.BaseType.PaddedSize, ...           % Bytearray effective size
        arrayName, ...                                  % Array name
        obj.BaseType.MATLABCastType, ...                % MATLAB type for casting
        obj.BaseType.MATLABType));                      % Effective, final MATLAB type
    
    % Increase arrayPointer;
    % TODO: Make this a parent method.
    functionScript = vertcat(functionScript, ...
        sprintf("arrayPointer = arrayPointer + %i;", ...
        obj.PaddedSize));
    
else                                    % NON-PRIMITIVE TYPES
    % In this case, we need to loop over the elements of the matrix, and retrieve the decoding from each children object, then parse the result in the corresponding matrix element.
    
    % We need to instantiate a for-loop; the index of the loop must be different according to the nesting level.
    indexLoop = repmat('j', 1, nestLevel);
    
    % We need to loop over only the effective elements
    % TODO: We could loop over only the effective size
    functionScript = vertcat(functionScript, ...
        sprintf("for %s=1:%i %% Variable size", indexLoop, obj.NumEl));
    
    %%%% Generate decoding lines for Base Type.
    % The increase of the arrayPointer is managed internally, so no need to manage inside the loop.
    
    % Generate a random name for the child.
    childAccessName = generateRandomString();
    % Retrieve decoding function for BaseType.
    outlines = obj.BaseType.generateDecoderFunction(childAccessName,  nestLevel+1);
    % Append the decoding function to the overall function script.
    functionScript = vertcat(functionScript, outlines);
    
    % If the index is smaller than the actual size, assign the value to the output matrix.
    % FIXME: Check if this works for different byte orders (i.e, row-wise). Otherwise remove if condition.
    functionScript = vertcat(functionScript, ...
        sprintf("if %s <= prod(%s_size)", indexLoop, arrayName), ...
        sprintf("%s(%s) = %s;", arrayName, indexLoop, childAccessName), ...
        sprintf("end"));
    
    % Close the loop
    functionScript = vertcat(functionScript, sprintf("end"));
    
    % We are out of the loop, so we need to increase the arrayPointer. In particular, we need to skip the size type entirely, because that is not transported in MATLAB.
    functionScript = vertcat(functionScript, ...
        sprintf("arrayPointer = arrayPointer + %i; %% Size", ...
        obj.SizeType.PaddedSize));
    
end

%%%% RESHAPE AND ASSIGN
if obj.SizeType.Dimension>1
    % Only the elements up to the effective size should be reshaped; otherwise, we have more elements than the actual size and reshape throws an error.
    % FIXME: Check if this works for different byte orders (i.e, row-wise).
    functionScript = vertcat(functionScript, ...
        sprintf("%s = reshape(%s(1:prod(%s_size)), %s_size);", ...
        accessName, arrayName, arrayName, arrayName));
else
    % It's just a vector, we need to make it a row vector.
    functionScript = vertcat(functionScript, ...
        strcat(sprintf("%s = reshape(%s, 1, []);", accessName, arrayName)));
end

% Increase arrayPointer
% This is needed in case the matrix is padded because i.e. part of a structure.
functionScript = vertcat(functionScript, ...
    sprintf("arrayPointer = arrayPointer + %i; %% Padding", ...
    obj.Padding));


end