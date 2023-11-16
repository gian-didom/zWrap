function [outputArg1,outputArg2] = downloadGNUMake()
%DOWNLOADTOOLS Summary of this function goes here
%   Detailed explanation goes here




if not(isfolder('tools')); mkdir('tools'); end
if not(isfolder(fullfile('tools', 'temp'))); mkdir(fullfile('tools', 'temp')); end
if not(isfolder(fullfile('tools', 'make'))); mkdir(fullfile('tools', 'temp', 'make')); end


switch computer
    case 'MACA64'
        % Download
        downloadLink = 'https://github.com/wkusnierczyk/make/archive/refs/heads/master.zip';
        [dwnStatus, ~] = system(sprintf('curl -o "make-master.zip" --output-dir %s -L "%s"', ...
                                                fullfile('tools', 'temp'), ...
                                                downloadLink), ...
                                        "-echo");
        assert(dwnStatus == 0, "Error in downloading GNU Make.")

        % Untar the package
        fprintf("Download completed. Extracting...\n");
        system(sprintf('tar -xvf %s -C %s --strip-components=1', ...
            fullfile('tools', 'temp', 'make-master.zip'), ...
            fullfile('tools', 'make')))
        fprintf("Extraction complete.");

        % Run configuration script
        fprintbf("Running configuration script...\n");
        [confFlag, ~] = system(sprintf("cd %s && ./configure", fullfile('tools', 'make')), '-echo');
        assert(confFlag == 0, "Error during GNU make configuration");

        % Run makefile - this takes a loong time
        fprintbf("Building make...\n");
        [compFlag, ~] = system(sprintf("cd %s && ./build.sh", fullfile('tools', 'make')), '-echo');
        assert(compFlag == 0, "Error during GNU make building.");

        % Try to execute make
        fprintbf("Trying to run make:\n");
        outFlag = system(sprintf("%s -version", fullfile("tools", "make", "make")));
        assert(outFlag == 0, "It seems that make compiled but couldn't be ran. " + ...
            "Please perform the installation manually.")
        
        % Clean
        delete(fullfile('tools', 'temp', 'make-master.zip'));
        fprintbf("GNU Make succesfully installed in %s\n", fullfile('tools', 'make'));

    case 'PCWIN64'
        downloadLink = 'https://downloads.sourceforge.net/project/gnuwin32/make/3.81/make-3.81-bin.zip';
        downloadLinkDeps = 'https://downloads.sourceforge.net/project/gnuwin32/make/3.81/make-3.81-dep.zip';
        
        fprintf("Downloading GNU Make for Windows...\n");
        [dwnStatus, ~] = system(sprintf('curl.exe -# -o make_bin.zip --output-dir %s -L %s', fullfile('tools', 'temp'), downloadLink));
        assert(dwnStatus == 0, "Error in downloading the ARM tools.")

        fprintf("Downloading dependencies...\n");
        [dwnStatus, ~] = system(sprintf('curl.exe -# -o make_dep.zip --output-dir %s -L %s', fullfile('tools', 'temp'), downloadLinkDeps));
        assert(dwnStatus == 0, "Error in downloading the ARM tools.")

        fprintf("Download completed. Extracting...\n");
        unzip(fullfile('tools', 'temp', 'make_bin.zip'), fullfile('tools', 'make'))
        mkdir(fullfile('tools', 'temp', 'make_deps'));
        unzip(fullfile('tools', 'temp', 'make_dep.zip'), fullfile('tools', 'temp', 'make_dep'));
        copyfile(fullfile('tools', 'temp', 'make_dep', 'bin', 'libintl3.dll'), fullfile('tools', 'make', 'bin', 'libintl3.dll'));
        copyfile(fullfile('tools', 'temp', 'make_dep', 'bin', 'libiconv2.dll'), fullfile('tools', 'make', 'bin', 'libiconv2.dll'));
        fprintf("Extraction complete. Trying to running make...");
        [mkStatus, ~] = system(sprintf("%s -v", fullfile("tools", "make", "bin", "make.exe")), '-echo');
        assert(mkStatus == 0, "Was not able to run make. Try to review the installation process or manually install make.exe");
        
        fprintf("GNU make succesfully downloaded.\n");
    case 'GLNXA64'

end

end

