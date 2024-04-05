function build_for_zWrap()

%% Clear environment
close all
clear

%% Select codegen options

useEmbeddedCoder = false;
cfg = coder.config( "lib", "ecoder", useEmbeddedCoder );

% cfg is of type coder.CodeConfig object
cfg.BuildConfiguration = 'Faster Runs';                         % 'Faster Runs' (default) | 'Faster Builds' | 'Debug' | 'Specify'
cfg.CppNamespaceForMathworksCode = 'coder';                     % 'coder' (default) | character vector
cfg.CppPreserveClasses = true;                                  % true (default) | false
cfg.EnableVariableSizing = true;                                % true (default) | false
cfg.GenCodeOnly = false;                                        % false (default) | true
cfg.GenerateComments = true;                                    % true (default) | false
cfg.GenerateReport = true;                                      % false (default) | true
cfg.InlineBetweenMathWorksFunctions = 'Speed';                  % 'Speed' (default) | 'Always' | 'Readability' | 'Never'
cfg.InlineBetweenUserAndMathWorksFunctions = 'Speed';           % 'Speed' (default) | 'Always' | 'Readability' | 'Never'
cfg.InlineBetweenUserFunctions = 'Speed';                       % 'Speed' (default) | 'Always' | 'Readability' | 'Never'
cfg.MATLABSourceComments = false;                               % false (default) | true
cfg.PreserveVariableNames = 'UserNames';                        % 'None' (default) | 'UserNames' | 'All'
cfg.RuntimeChecks = true;                                       % false (default) | true
% cfg.MultiInstanceCode = true;                                   % false (default) | true

%% zWrap toolchain specific

% Warning: This StackUsageMax does not always propagte
% correctly to the compiler flags of the active toolchain.
% You can check the LDFLAGS in the generated make files for
% the presence of the correct flags, e.g.
% for Visual Studio: /STACK:8388608,8388608
% for MinGW: -Wl,-stack,0x800000 or -Wl,-stack=0x800000
cfg.StackUsageMax = 4194304;                                    % 200000 (default) | positive integer

% Dynamic Memory Allocation does not work with zWrap toolchain
cfg.DynamicMemoryAllocation = "off";                            % 'Threshold' (default) | 'AllVariableSizeArrays' | 'Off'
cfg.HardwareImplementation.ProdHWDeviceType = "ARM Compatible->ARM 9";
cfg.HardwareImplementation.TargetHWDeviceType = "ARM Compatible->ARM 9";

cfg.TargetLang = "C++";                                         % 'C' (default) | 'C++'
cfg.TargetLangStandard = 'Auto';                                % 'Auto' (default) | 'C89/C90 (ANSI)' | 'C99 (ISO)' | 'C++03 (ISO)' | 'C++11 (ISO)'
cfg.Toolchain = "MinGW64 | gmake (64-bit Windows)";             % 'Automatically locate an installed toolchain' (default) | character vector
cfg.Verbose = true;                                             % false (default) | true
cfg.Verbosity = 'Verbose';                                      % 'Info' (default) | 'Silent' | 'Verbose'

% R2023b
%             cfg.DynamicMemoryAllocationForFixedSizeArrays = false;        % false (default) | true
%             cfg.EnableDynamicMemoryAllocation = false;                    % true (default) | false
%             cfg.MATLABSourceCommentLineNumbers = true;                    % true (default) | false


%% Generate Code

% Navigate to current folder (output dir for codegen dump)
[ thisFileDir, ~, ~ ] = fileparts( mfilename('fullpath') );

cd( thisFileDir );
codegen_dirs = genpath(fullfile(thisFileDir, 'codegen'));

if ~ isempty( codegen_dirs )
    addpath( codegen_dirs );
    rmpath( codegen_dirs );
end

% Generate code
% replace with your entry function and example arguments
codegen( 'example_entry_function', '-config', 'cfg' , '-args', {-5, 'exampleString'});

end

