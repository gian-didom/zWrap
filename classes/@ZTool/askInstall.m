% ========================================================================
        % Install interactive interface - not to be overridden.
        function installed = askInstall(obj)
            fprintbf("Do you want to download and install %s locally? [Y/n]", obj.name);
            answer = input(">> ", 's');
            switch answer
                case {'Y', 'y', ''}
                    obj.install();
                    installed = obj.check();
                otherwise
                    obj.fail("%s needed to run zWrap.", obj.name); 
            end
                    
        end