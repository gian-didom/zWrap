%% function dataRepr = mappingFunction(obj, inputVariable)
        % Mapping function
        function dataRepr = mappingFunction(obj, inputVariable)
            if (obj.hasSizeArray && not(obj.isSizeArray))

                % ******* PADDING - IS NOT NEEDED MOST PROBABLY *********
                % This is such a nasty trick :emoji laughing:
                % I_AM_NASTY = true;
                % if AM_I_NASTY
                %     eval(strcat("inputVariable[", strjoin(arrayfun(@(x) num2str(x), obj.Dimension, 'UniformOutput', false), ','), '] = 0;'));
                % else % I_AM_BORING
                %     % Ehhhhh now you need the Image Processing Toolbox.
                %     inputSize = size(inputVariable);
                %     inputSizePadded = obj.Dimensions.^0;
                %     inputSizePadded(1:numel(inputSize)) = inputSize;
                %     inputVariable = padarray(inputVariable, obj.Dimensions - inputSizePadded, 'post');
                % end
                % Now you can go on...

                dataRepr = typecast(cast(inputVariable(:),obj.MATLABType), 'uint8');
                if numel(dataRepr) < obj.Size
                    % We must add zeros because the matrix is smaller
                    dataRepr(obj.Size) = 0;
                end
            elseif (obj.isSizeArray && not(obj.hasSizeArray))
                dataRepr = typecast(cast(size(inputVariable), 'int32'), 'uint8');
            else
                dataRepr = typecast(cast(inputVariable(:), obj.MATLABType), 'uint8');
            end
            % TODO: Add special case for logical
        end