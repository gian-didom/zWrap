function [outFlag, openSSLDir, openSSLIncludeDir, openSSLLibDir] = getOpenSSLPath()
% getOpenSSLPath Summary of this function goes here
%   Detailed explanation goes here

outFlag = false;
openSSLDir = "";
openSSLIncludeDir = "";
openSSLLibDir = "";

switch computer
    case 'MACA64'
        possiblePaths = getSystemLibPaths();
        hasOpenSSL = cellfun(@(x) and(isfile(fullfile(x, 'libssl.a')), isfile(fullfile(x, 'libcrypto.a'))), possiblePaths);
        if not(any(hasOpenSSL))
            outFlag = false;
            return;
        end

        outFlag = true;
        openSSLLibDir = possiblePaths{find(hasOpenSSL, 1)};
        openSSLDir = fileparts(openSSLLibDir);
        openSSLIncludeDir = fullfile(openSSLDir, 'include');

    case 'PCWIN64'

        % Check if OpenSSL is installed.
        openSSLPaths = {fullfile('tools', 'bootgen', 'openssl', 'bin', 'openssl.exe');
                        fullfile('C:', 'Program Files', 'OpenSSL','bin', 'openssl.exe');
                        fullfile('C:', 'Program Files', 'OpenSSL-Win64','bin', 'openssl.exe');
                        };
        openSSLFlags = ones(numel(openSSLPaths), 1);
        for j=1:numel(openSSLPaths)
            openSSLFlags(j) = system(sprintf('"%s" version', openSSLPaths{j}));
        end
            

        if not(any(openSSLFlags == 0))
            fprintf("OpenSSL not found in system.");
            outFlag = false;
            return;
        end

        % Check the presence of libs
        openSSLPaths = {openSSLPaths{openSSLFlags == 0}};     % Filter down search paths
        for j=1:numel(openSSLPaths)
            pth = openSSLPaths{j};
            if not(isfile(pth))
                % Then it's an executable already in path. Get its location
                [~, outCmd] = system(sprintf('where "%s"', pth), '-echo');
                openSSLPaths{j} = strrep(outCmd, newline, '');
            end
        end
        
        openSSLBaseDirs = cellfun(@(x) fileparts(fileparts(x)), openSSLPaths, 'UniformOutput', false);

        hasLibCrypto = cellfun(@(x) isfile(fullfile(x, 'lib', 'libcrypto.lib')), openSSLBaseDirs);
        hasLibSSL = cellfun(@(x) isfile(fullfile(x, 'lib', 'libssl.lib')), openSSLBaseDirs);
        hasLibraries = and(hasLibCrypto, hasLibSSL);

        if not(any(hasLibraries))
            fprintf("OpenSSL found in system, but the linkable libs have not been found.");
            outFlag = false;
            return;
        end
        
        % Get first useful OpenSSL
        openSSLDir = openSSLBaseDirs{find(hasLibraries, 1)}; tmp = what(openSSLDir); openSSLDir = tmp.path;
        openSSLIncludeDir = fullfile(openSSLDir, 'include');
        openSSLLibDir = fullfile(openSSLDir, 'lib');
        outFlag = true;

    case 'GLNXA64'

end

end

