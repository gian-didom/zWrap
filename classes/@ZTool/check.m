% ========================================================================
        % Check interface - not to be overridden.
        function installed = check(obj, ask)
            if nargin == 1
                ask = true;
            end

            for dep=obj.dependencies
                % TODO: Check if an object exists with the name.
                % Maybe should list availableTools in a structure
                % or load all the object in the project availableTools folder.
                fprintf("Checking for %s\n", dep);
            end

            installed = obj.checkInstall();
            if ~installed && ask
                installed = obj.askInstall();
            end
        end 