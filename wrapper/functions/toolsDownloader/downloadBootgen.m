function [outputArg1,outputArg2] = downloadBootgen()
%DOWNLOADTOOLS Summary of this function goes here
%   Detailed explanation goes here

switch computer
    case 'MACA64'
        % Download
        downloadLink = 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-mac.tar.bz2?rev=58ed196feb7b4ada8288ea521fa87ad5&hash=62C9BE56E5F15D7C2D98F48BFCF2E839D7933597';
        [dwnStatus, ~] = system(sprintf('curl -# -o "armCompilerLatest.tar.bz2" --output-dir %s -L "%s"', ...
                                                fullfile('tools', 'temp'), ...
                                                downloadLink), ...
                                        "-echo");
        assert(dwnStatus == 0, "Error in downloading the ARM tools.")

        % Untar the package
        fprintbf("Download completed. Extracting...\n");
        system(sprintf('tar -xvf %s -C %s --strip-components=1', fullfile('tools', 'temp', 'armCompilerLatest.tar.bz2'), fullfile('tools', 'arm-none-eabi')))
        fprintbf("Extraction complete.");
        
        % Clean
        delete(fullfile('tools', 'temp', 'armCompilerLatest.tar.bz2'));
        fprintbf("ARM GNU Compiler and tools succesfully installed in %s", fullfile('tools', 'arm-none-eabi'));

    case 'PCWIN64'

        [openSSLFlag, openSSLDir, openSSLIncludeDir, openSSLLibDir] = getOpenSSLPath();
        if not(openSSLFlag)
            fprintbf("OpenSSL not found. Downloading from source...");
            % Download OpenSSL from source
            downloadOpenSSLLink = 'https://slproweb.com/download/Win64OpenSSL-3_1_3.exe';
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
        movefile(sprintf("%s*", extractDir), fullfile('tools', 'bootgen'));
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

