function [outputArg1,outputArg2] = downloadGNUMake()
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
        fprintf("Download completed. Extracting...\n");
        system(sprintf('tar -xvf %s -C %s --strip-components=1', fullfile('tools', 'temp', 'armCompilerLatest.tar.bz2'), fullfile('tools', 'arm-none-eabi')))
        fprintf("Extraction complete.");
        
        % Clean
        delete(fullfile('tools', 'temp', 'armCompilerLatest.tar.bz2'));
        fprintf("ARM GNU Compiler and tools succesfully installed in %s", fullfile('tools', 'arm-none-eabi'));

    case 'PCWIN64'
        downloadLink = 'https://downloads.sourceforge.net/project/gnuwin32/make/3.81/make-3.81-bin.zip';
        downloadLinkDeps = 'https://downloads.sourceforge.net/project/gnuwin32/make/3.81/make-3.81-dep.zip';
        
        fprintf("Downloading GNU Make for Windows...");
        [dwnStatus, ~] = system(sprintf('curl -# -o make_bin.zip --output-dir %s -L %s', fullfile('tools', 'temp'), downloadLink));
        assert(dwnStatus == 0, "Error in downloading the ARM tools.")

        fprintf("Downloading dependencies...");
        [dwnStatus, ~] = system(sprintf('curl -# -o make_dep.zip --output-dir %s -L %s', fullfile('tools', 'temp'), downloadLinkDeps));
        assert(dwnStatus == 0, "Error in downloading the ARM tools.")

        fprintf("Download completed. Extracting...\n");
        unzip(fullfile('tools', 'temp', 'make_bin.zip'), fullfile('tools', 'make'))
        mkdir(fullfile('tools', 'temp', 'make_deps'));
        unzip(fullfile('tools', 'temp', 'make_dep.zip'), fullfile('tools', 'temp', 'make_dep'));
        copyfile(fullfile('tools', 'temp', 'make_dep', 'bin', 'libintl3.dll'), fullfile('tools', 'make', 'bin', 'libintl3.dll'));
        copyfile(fullfile('tools', 'temp', 'make_dep', 'bin', 'libiconv2.dll'), fullfile('tools', 'make', 'bin', 'libiconv2.dll'));
        fprintf("Extraction complete. Trying to running make...");
        [mkStatus, ~] = system(fullfile("tools", "make", "bin", "make.exe"), '-echo');
        assert(mkStatus == 0, "Was not able to run make. Try to review the installation process or manually install make.exe");

    case 'GLNXA64'

end

end

