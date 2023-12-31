classdef (HandleCompatible) fullInterfaceStructure < coderNestedObject
    %UNTITLED11 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        fcnName
        headerName
    end

    methods
        function obj = fullInterfaceStructure(codeInfoObject, type)
            %UNTITLED11 Construct an instance of this class
            %   Detailed explanation goes{ here
            % We're at the top level - this is the top-level structure!
            obj@coderNestedObject(codeInfoObject);
            switch type
                case 'input'
                    obj.setName('FULL_INPUT_STRUCTURE');
                    obj.Role = 'input';
                    fieldToLook = 'Inports';
                    roleToAssign = 'input';
                case 'output'
                    obj.setName('FULL_OUTPUT_STRUCTURE');
                    obj.Role = 'output';
                    fieldToLook = 'Outports';
                    roleToAssign = 'output';
                otherwise
                    error('type should be either ''input'' or ''output'' for this to work');
            end
            obj.Type = 'struct';
            obj.ByteSize= NaN;         % Right now, not a number
            obj.Padding = 0;
            obj.Children = [];
            obj.fcnName = codeInfoObject.OutputFunctions.Prototype.Name; % or GraphicalPath?
            obj.headerName = codeInfoObject.Name;

            if not(strcmp(obj.fcnName, obj.headerName))
                obj.Coder = 'Simulink';
            else
                obj.Coder = 'MATLAB';
            end

            for j=1:numel(codeInfoObject.(fieldToLook))
                % Find variable in output function prototype
                % WARNING: This should NOT work with variable-size
                % matrices. Indeed, the Identifier name is probably
                % different with respect to the Prototype name for
                % multi-split inputs (i.e., matrices with size and data)
                % - Cannot use contains to avoid false positives
                % - Could check after the object expansion, before
                %   assigning

                output = coderArgument.processObject2(codeInfoObject.(fieldToLook)(j));

                indexPrototype = strcmp(output.argNames{1}, ...
                    {codeInfoObject.OutputFunctions(1).Prototype.Arguments.Name});

                assert(sum(indexPrototype) <= 1, "Error: multiple I/O arguments with same name.");

                if not(any(indexPrototype))
                    % This has been unused and removed. Good, ignore.
                    continue;
                else
                    
                    % Set role - I/O - to all elements for this I/O port.
                    if numel(output)>1
                        for jc=1:numel(output)
                            output{jc}.Role = roleToAssign; 
                        end
                    else 
                        output.Role = roleToAssign; 
                    end

                    % Set argument pass mode - value or pointer
                    if class(codeInfoObject.OutputFunctions(1).Prototype.Arguments(indexPrototype).Type) == "coder.types.Pointer"
                        output.passedBy = 'pointer';
                    end

                    % Append elements to interface children
                    obj.Children = appendCell(obj.Children, output);

                end
            end

                

                obj.AlignmentRequirement = max(arrayfun(@(x) x.AlignmentRequirement, obj.Children));

            

            % Assign coder value to all Children.
            for jc=1:numel(obj.Children)
                    obj.Children(jc).Coder = obj.Coder;
            end
        end


            %% function functionScript = generateMATLABFunction(obj, savepath)
            function functionScript = generateMATLABFunction(obj, savepath, test)


                if nargin == 2
                    test = false;
                end

                if not(test)
                    % The accessName is given from the parent
                    savepath = fullfile(savepath, sprintf('%s_inputSerializer.m', obj.fcnName));

                    functionScript = {};
                    if numel(obj.Children) > 1
                        functionScript = vertcat(functionScript, ...
                            strcat(sprintf('function byteArray = %s_inputSerializer(', obj.fcnName), ...
                            sprintf('input%i, ', 1:numel(obj.Children)-1), ...
                            sprintf(' input%i)\n', numel(obj.Children))));
                    else
                        functionScript = vertcat(functionScript, ...
                            sprintf('function byteArray = %s_inputSerializer(input1)\n', obj.fcnName));
                    end

                else
                    savepath = fullfile(savepath, sprintf('%s_inputSerializer_test.m', obj.fcnName));

                    functionScript = {};
                    if numel(obj.Children) > 1
                        functionScript = vertcat(functionScript, ...
                            strcat(sprintf('function byteArray = %s_inputSerializer_test(', obj.fcnName), ...
                            sprintf('input%i, ', 1:numel(obj.Children)-1), ...
                            sprintf(' input%i)\n', numel(obj.Children))));
                    else
                        functionScript = vertcat(functionScript, ...
                            sprintf('function byteArray = %s_inputSerializer_test(input1)\n', obj.fcnName));
                    end
                end



                functionScript = vertcat(functionScript, ...
                    sprintf("byteArray = uint8(zeros(%i, 1));", obj.getTotalSizePadded()));
                % This is a struct, so we need multiple lines
                for j=1:numel(obj.Children)
                    functionScript = vertcat(functionScript, sprintf('\n\n%%%% input%i', j));
                    outlines = obj.Children(j).generateMATLABFunction(sprintf('input%i', j), 1);
                    functionScript = vertcat(functionScript, outlines);
                end
                % lhs = sprintf('byteArray[%i:%i+%i] ', obj.memoryOffset, obj.memoryOffset, obj.ByteSize);
                % rhs = sprintf('typecast%s')


                functionScript = vertcat(functionScript, sprintf("\nend"));
                if nargin >= 2
                    % Save to path
                    fid = fopen(savepath, 'w');
                    fprintf(fid, "%s\n", functionScript);
                    fclose(fid);

                    function_saved_path = which(savepath);
                    h = matlab.desktop.editor.openDocument(function_saved_path);
                    h.smartIndentContents
                    h.save
                    h.close
                end

            end

            %% function functionScript = generateMATLABFunction(obj, accessName)

            function functionScript = generateDecoderFunction(obj, savepath, test)

                if nargin == 2
                    test = false;
                end

                if not(test)
                    savepath = fullfile(savepath, sprintf('%s_outputParser.m', obj.fcnName));
                    functionScript = {};
                    functionScript = vertcat(functionScript, ...
                        strcat(sprintf('function ['), sprintf('output%i ', 1:numel(obj.Children)), ...
                        sprintf(']  = %s_outputParser(byteArray)', obj.fcnName)));
                else
                    savepath = fullfile(savepath, sprintf('%s_outputParser_test.m', obj.fcnName));
                    functionScript = {};
                    functionScript = vertcat(functionScript, ...
                        strcat(sprintf('function ['), sprintf('output%i ', 1:numel(obj.Children)), ...
                        sprintf(']  = %s_outputParser_test(byteArray)', obj.fcnName)));
                end
                % The accessName is given from the parent



                % This is the array pointer: it goes forward according to each
                % element that is read out of the input byteArray.
                % Only primitive members can increase the arrayPointer by
                % direct summation; non-primitive members should just account
                % for the padding.
                functionScript = vertcat(functionScript, ...
                    sprintf('arrayPointer = 0;'));

                % This is a struct, so we need multiple lines
                for j=1:numel(obj.Children)
                    functionScript = vertcat(functionScript, sprintf('\n\n%%%% output%i', j));
                    outlines = obj.Children(j).generateDecoderFunction(sprintf('output%i', j), 1);
                    functionScript = vertcat(functionScript, outlines);
                end
                % lhs = sprintf('byteArray[%i:%i+%i] ', obj.memoryOffset, obj.memoryOffset, obj.ByteSize);
                % rhs = sprintf('typecast%s')


                functionScript = vertcat(functionScript, sprintf("\nend"));
                if nargin >= 2
                    % Save to path
                    fid = fopen(savepath, 'w');
                    fprintf(fid, "%s\n", functionScript);
                    fclose(fid);

                    function_saved_path = which(savepath);
                    h = matlab.desktop.editor.openDocument(function_saved_path);
                    h.smartIndentContents
                    h.save
                    h.close
                end

            end




        end
    end