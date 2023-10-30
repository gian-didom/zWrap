function [outputArg1,outputArg2] = downloadARMTools()
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
        downloadLink = 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.zip?rev=8f4a92e2ec2040f89912f372a55d8cf3&hash=8A9EAF77EF1957B779C59EADDBF2DAC118170BBF';

    case 'GLNXA64'

end

end

