% ========================================================================
        % Install interface - must be implemented for all subclasses. 
        % This selector should NOT be overridden - instead, override the
        % OS implementations.
        function install(obj)
            % Check platform
            switch computer
                
                case 'MACA64';  obj.installMac();
                case 'GLNXA64'; obj.installLinux();
                case 'PCWIN64'; obj.installWin();
                otherwise;      error("Architecture not supported for install.")
            end
                
        end