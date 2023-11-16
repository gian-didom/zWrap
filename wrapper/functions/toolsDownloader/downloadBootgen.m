function [outputArg1,outputArg2] = downloadBootgen()
global zEnv
%DOWNLOADTOOLS Summary of this function goes here
%   Detailed explanation goes here


if not(isfolder('tools')); mkdir('tools'); end
if not(isfolder(fullfile('tools', 'temp'))); mkdir(fullfile('tools', 'temp')); end
if not(isfolder(fullfile('tools', 'bootgen'))); mkdir(fullfile('tools', 'temp', 'bootgen')); end


switch computer
    case 'MACA64'
        % Download
        [openSSLFlag, openSSLDir, openSSLIncludeDir, openSSLLibDir] = getOpenSSLPath();

        if not(openSSLFlag)
            % Clear existing
            if isfolder(fullfile("tools", "bootgen", "openssl"))
                rmdir(fullfile("tools", "bootgen", "openssl"), 's')
            end
            
            fprintbf("OpenSSL not found. Downloading from source...\n");
            % Download OpenSSL from source
            downloadOpenSSLLink = 'https://github.com/openssl/openssl/archive/refs/heads/master.zip';
            [dwnStatus, ~] = system(sprintf('curl -o "openssl-master.zip" --output-dir %s -L "%s"', ...
                fullfile('tools', 'temp'), ...
                downloadOpenSSLLink), ...
                "-echo");
            assert(dwnStatus == 0, "Error in downloading OpenSSL.");


            mkdir(fullfile("tools", "bootgen", "openssl"));
            % Unzip the package
            fprintbf("Download completed. Extracting...\n");
            extractedFiles = unzip(fullfile('tools', 'temp', 'openssl-master.zip'), ...
                                    fullfile('tools', 'bootgen', 'openssl'));
            fprintbf("Extraction complete.\n");

            % Reshape dirs, everything up one level
            extractDir = extractedFiles{1};
            movefile(sprintf("%s*", extractDir), fullfile('tools', 'bootgen', 'openssl'), 'f');
            rmdir(extractDir);

            % Run configuration script
            fprintbf("Running configuration script...\n");
            [confFlag, none] = system(sprintf("cd %s && ./Configure", fullfile('tools', 'bootgen', 'openssl')), '-echo');
            assert(confFlag == 0, "Error during OpenSSL configuration");

            % Run makefile - this takes a loong time
            fprintbf("Compiling OpenSSL...\n");
            [compFlag, none] = system(sprintf("cd %s && %s", fullfile('tools', 'bootgen', 'openssl'), zEnv.makeBin), '-echo');
            assert(compFlag == 0, "Error during OpenSSL compilation.");

            % Move built libraries
            mkdir(fullfile("tools", "bootgen", "openssl", "lib"));
            movefile(fullfile("tools", "bootgen", "openssl", "libcrypto.a"), ...
                fullfile("tools", "bootgen", "openssl", "lib", "libcrypto.a"), 'f');
            movefile(fullfile("tools", "bootgen", "openssl", "libssl.a"), ...
                fullfile("tools", "bootgen", "openssl", "lib", "libssl.a"), 'f');

            % Finished downloading OpenSSL - set variables
            openSSLDir = fullfile("tools", "bootgen", "openssl"); 
            openSSLDir = what(openSSLDir); openSSLDir = openSSLDir.path;
            
            openSSLIncludeDir = fullfile(openSSLDir, "include");
            openSSLLibDir = fullfile(openSSLDir, "lib");
            fprintbf("OpenSSL succesfully installed locally.\n");

        end


        % Download bootgen from source.
        fprintbf("Downloading bootgen from GitHub...\n");
        downloadLink = 'https://github.com/Xilinx/bootgen/archive/refs/heads/master.zip';
        [dwnStatus, ~] = system(sprintf('curl -o "bootgen-master.zip" --output-dir %s -L "%s"', ...
                                                fullfile('tools', 'temp'), ...
                                                downloadLink), ...
                                        "-echo");
        assert(dwnStatus == 0, "Error in downloading bootgen.")

        % Untar the package
        fprintbf("Download completed. Extracting...\n");
        extractedFiles = unzip(fullfile('tools', 'temp', 'bootgen-master.zip'), fullfile('tools', 'bootgen'));
        fprintbf("Extraction complete.");

        % Reshape dirs, everything up one level
        extractDir = extractedFiles{1};
        movefile(sprintf("%s*", extractDir), fullfile('tools', 'bootgen'), 'f');
        rmdir(extractDir);

        % In order to compile on MacOS, we need to comment all the #include
        % <malloc.h>. Unfortunately Xilinx guys are not aware that the
        % stanard POSIX malloc is already defined in stdlib.hm and that not
        % every UNIX platform has a defined header for that...
        fprintbf("Applying malloc fix for MacOS...\n");
        sourceFiles = dir(fullfile("tools", "bootgen")); sourceFiles = {sourceFiles.name};
        sourceFiles = sourceFiles(cellfun(@(x) contains(x, {'.c', '.h'}), sourceFiles).');
        cellfun(@(x) replaceInFile( ...
            fullfile("tools", "bootgen", x), ...
            "#include <malloc.h>", ...
            "// #include <malloc.h>"), sourceFiles);

        fprintbf("Building bootgen...\n");
        [compFlag, none] = system(sprintf('cd %s && %s "LIBS=-ldl -lpthread ''%s'' ''%s''" "INCLUDE_USER=-I %s"', ...
            fullfile('tools', 'bootgen'), ...
            zEnv.makeBin, ...
            fullfile(openSSLLibDir, "libcrypto.a"), ...
            fullfile(openSSLLibDir, "libssl.a"), ...
            openSSLIncludeDir), '-echo');

        assert(compFlag == 0, "Error during bootgen compilation. Let's cry at Xilinx.");


        % Try to execute bootgen
        fprintbf("Trying to run bootgen:\n");
        outFlag = system(fullfile("tools", "bootgen", "bootgen"));
        assert(outFlag == 0, "It seems that bootgen compiled but couldn't be ran. " + ...
            "Please perform the installation manually. We know it's not easy but that's what Xilinx gave us...")
        
                            % Clean
        delete(fullfile('tools', 'temp', 'bootgen-master.zip'));
        fprintbf("Bootgen has been succesfully (and incredibly!!) installed in %s\n", fullfile('tools', 'bootgen'));

    case 'PCWIN64'

        [openSSLFlag, openSSLDir, openSSLIncludeDir, openSSLLibDir] = getOpenSSLPath();
        if not(openSSLFlag)
            fprintbf("OpenSSL not found. Downloading from source...");
            % Download OpenSSL from source
            downloadOpenSSLLink = 'https://slproweb.com/download/Win64OpenSSL-3_1_4.exe';
            [dwnStatus, ~] = system(sprintf('curl.exe -o "openssl-win64-3_1_3.exe" --output-dir %s -L "%s"', ...
                fullfile('tools', 'temp'), ...
                downloadOpenSSLLink), ...
                "-echo");
            assert(dwnStatus == 0, "Error in downloading OpenSSL.");



            % Extract OpenSSL in folder
            mkdir(fullfile("tools", "bootgen", "openssl"));
            [extStatus, ~] =  system(sprintf('"%s" /VERYSILENT /DIR="%s"', ...
                    fullfile("tools", "temp", "openssl-win64-3_1_3.exe"), ...
                    fullfile("tools", "bootgen", "openssl")), '-echo');
            assert(extStatus == 0, "Error in extracting OpenSSL.");
            
            % Finished downloading OpenSSL - set variables
            openSSLDir = fullfile("tools", "bootgen", "openssl"); openSSLDir = what(openSSLDir); openSSLDir = openSSLDir.path;
            openSSLIncludeDir = fullfile(openSSLDir, "include");
            openSSLLibDir = fullfile(openSSLDir, "lib");
        end

        % Download bootgen from source.
        downloadLink = 'https://github.com/Xilinx/bootgen/archive/refs/heads/master.zip';
        [dwnStatus, ~] = system(sprintf('curl.exe -o "bootgen-master.zip" --output-dir %s -L "%s"', ...
                                                fullfile('tools', 'temp'), ...
                                                downloadLink), ...
                                        "-echo");
        assert(dwnStatus == 0, "Error in downloading bootgen.")

        % Untar the package
        fprintbf("Download completed. Extracting...\n");
        extractedFiles = unzip(fullfile('tools', 'temp', 'bootgen-master.zip'), fullfile('tools', 'bootgen'));
        fprintbf("Extraction complete.");

        % Reshape dirs, everything up one level
        extractDir = extractedFiles{1};
        movefile(sprintf("%s*", extractDir), fullfile('tools', 'bootgen'), 'f');
        rmdir(extractDir);

        % BUGFIX: Remove this because the OpenSSL installation does NOT
        % generate a /ms subdirectory. We don't need applink anyway.
        % Probably it's there because of _WIN32 but _WIN32 is defined also
        % on x64 by standard.
        replaceInFile(fullfile("tools", "bootgen", "main.cpp"), ...
            '#include "openssl/ms/applink.c"', ...
            '// #include "openssl/ms/applink.c"');

        % BUGFIX: Someone complains about unistd. There is a Windows unistd
        % implementation but my assumption is that it's not needed

        % Get compiler information from MATLAB mex info
        compConfs = mex.getCompilerConfigurations;
        assert(numel(compConfs)>0, "Error: no compiler configurations present in the MATLAB environment. " + ...
            "Please install a Microsoft Visual Studio compiler or manually compile bootgen.");
        
        compc = compConfs(1);
        cmdList = split(strrep(compc.Details.SetEnv, '  ', ''), newline);
        cmdList = cmdList(cellfun(@(x) not(isempty(x)), cmdList));
        cmdList = vertcat(cmdList, sprintf(" cd %s", fullfile("tools", "bootgen")));

        compilerArgs = {'/EHsc';
            '/I.';
            '/I"win_include"';
            '/D YY_NO_UNISTD_H';
            char(sprintf('/I"%s"', openSSLIncludeDir));
            '*.cpp';
            '*.c';
            '/link';
            char(sprintf('/LIBPATH:"%s"', openSSLLibDir));
            'libssl.lib'; 
            'libcrypto.lib';
             '/OUT:bootgen.exe'};

        compilerCmd = join([compc.Details.CompilerExecutable; compilerArgs], " ");
        cmdList = vertcat(cmdList, compilerCmd);
        fullCmd = join(cmdList, " && ");
        outFlag = system(fullCmd);

        assert(outFlag == 0, "There have been problems in compiling bootgen. " + ...
            "Please perform the procedure manually. We know it's not easy but that's what Xilinx gave us...")
        
        % Try to execute bootgen
        outFlag = system(fullfile("tools", "bootgen", "bootgen.exe"));
        assert(outFlag == 0, "It seems that bootgen compiled but couldn't be ran. " + ...
            "Please perform the installation manually. We know it's not easy but that's what Xilinx gave us...")
        
                            % Clean
        delete(fullfile('tools', 'temp', 'bootgen-master.zip'));
        fprintBf("Bootgen has been succesfully (and incredibly!!) installed in %s\n", fullfile('tools', 'bootgen'));

    case 'GLNXA64'

end

end

