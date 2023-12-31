function result = downloadARMTools()
%DOWNLOADTOOLS Summary of this function goes here
%   Detailed explanation goes here

result = false;

if not(isfolder('tools')); mkdir('tools'); end
if not(isfolder(fullfile('tools', 'temp'))); mkdir(fullfile('tools', 'temp')); end
if not(isfolder(fullfile('tools', 'arm-none-eabi'))); mkdir(fullfile('tools', 'temp', 'arm-none-eabi')); end


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

        result = true;
        return;

    case 'PCWIN64'
        % Download

        downloadLink = 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-win32.zip';
        [dwnStatus, ~] = system(sprintf('curl.exe -o "armCompilerLatest.zip" --output-dir %s -L "%s"', ...
                                                fullfile('tools', 'temp'), ...
                                                downloadLink), ...
                                        "-echo");
        assert(dwnStatus == 0, "Error in downloading the ARM tools.")

        % Untar the package
        fprintbf("Download completed. Extracting...\n");
        extractedFiles = unzip(fullfile('tools', 'temp', 'armCompilerLatest.zip'), fullfile('tools', 'arm-none-eabi'));
        fprintbf("Extraction complete.");

        % Reshape dirs, everything up one level
        extractDir = extractedFiles{1};
        movefile(sprintf("%s*", extractDir), fullfile('tools', 'arm-none-eabi'));
        rmdir(extractDir);
        
        % Clean
        delete(fullfile('tools', 'temp', 'armCompilerLatest.zip'));
        fprintbf("ARM GNU Compiler and tools succesfully installed in %s", fullfile('tools', 'arm-none-eabi'));
        result = true;
        return;

    case 'GLNXA64'

end

end

