classdef ZSettings
    %ZWRAPSETTINGS Summary of this class goes here
    %   Detailed explanation goes here

    properties (SetAccess=private)
        path                = ""                % Path of the coded folder
        ip                  = ""                % IP to assign the board
        udpport             = 7                 % UDP port
        tcpport             = 8                 % TCP port
        stack               = ""                % Stack size in bytes
        heap                = ""                % Heap size in bytes
        baud                = ""                % Baud rate for Serial comm
        customArmPath       = ""                % Custom path for ARM tools
        customMakePath      = ""                % Custom path for make tool
        customBootgenPath   = ""                % Custom path for bootgen
        customXilinxPath    = ""                % Custom path for Xilinx installation
        board               = ""                % Board type
        limstack            = false;            % 
        async               = false;            % Async type 1
        async2              = false;            % Async type 2
        rt                  = false;            % Real-time in Simulink
        unprotect           = false;            % Unprotect
        debug               = false;            % Compile with debug settings
        y                   = false;            % Force "yes"
        no_ocm              = false;            % Do not use on-chip memory
        pack                = false;            % Directory is already packed
        nosimulink          = false;            % Do not generate Simulink block
        simcell2struct      = false;            % Convert cells to structures for Simulink
        cf                  = {};               % List of user-defined compile flags
        ext                 = {};               % List of board extensions
        cp                  = struct.empty()    % List of custom paths

    end

    methods
        % =====================================================
        % zWrapSettings =======================================
        % TODO: Consider using also Name-Value MATLAB parsing
        function obj = ZSettings(argstring)

            if nargin == 0
                return
            end
            

            %ZWRAPSETTINGS Construct an instance of this class
            %   Detailed explanation goes here
            % Split string with " -"
            argSplit = split(argstring, " -").';

            % Iterate over the arguments
            for arg=argSplit

                % If it contains a space, then it is a Name-Value.
                % If it a list, does not contain a space.
                % If is a trigger, does not contain a space.
                isNameValue = contains(arg, " ");
                isList = contains(arg, ":");
                isNameValueList = isNameValue && isList;


                if isNameValueList
                    % List argument handling
                    splittedArg = split(arg, ":");
                    List = splittedArg{1};
                    Value = strjoin(splittedArg(2:end));
                    % Name-Value argument handling
                    splittedArg = split(Value, " ");
                    Name = splittedArg{1}; if (Name(1) == '-'); Name = Name(2:end); end
                    Value = strjoin(splittedArg(2:end));
                    obj.(List).(Name) = Value;

                elseif isNameValue
                    % Name-Value argument handling
                    splittedArg = split(arg, " ");
                    Name = splittedArg{1}; if (Name(1) == '-'); Name = Name(2:end); end
                    Value = strjoin(splittedArg(2:end));
                    obj.(Name) = Value;

                elseif isList
                    % List argument handling
                    splittedArg = split(arg, ":");
                    List = splittedArg{1};
                    Value = strjoin(splittedArg(2:end));
                    obj.(List){end+1} = Value;

                else
                    % Trigger argument handling
                    obj.(arg) = true;
                end

            end

        end

        % =====================================================
        % =====================================================

    
    end
end

