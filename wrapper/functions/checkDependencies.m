function checkDependencies()
global zSettings zEnv
%=============================================================== ARM tools

checkARMTools();    % Checks path of ARM tools and adds the path to zEnv
if isempty(zEnv.armPath) || zSettings.downloadarm
    fprintbf("Do you want to download and install ARM tools locally? [Y/n]")
    answer = input("",'s');
    switch answer
        case {'Y', 'y', ''}
            downloadARMTools(); checkDependencies(); return;
        otherwise
            error("ARM tools are needed to run zWrap.");

    end
end

%================================================================ GNU make

checkGNUMake();    % Checks path of GNU make and adds the path to zEnv

if isempty(zEnv.makePath) || zSettings.downloadmake
    fprintbf("Do you want to download and install GNU make locally? [Y/n] ")
    answer = input("", 's');
    switch answer
        case {'Y', 'y', ''}
            downloadGNUMake(); checkDependencies(); return;
        otherwise
            warning("GNU make is needed to compile zWrap." + ...
                "You can generate the makefiles and the Simulink block, " + ...
                "but you cannot generate the .elf and the BOOT.bin image");
    end
end

%================================================================= Bootgen
checkBootgen();    % Checks path of bootgen and adds the path to zEnv
if isempty(zEnv.bootgenPath) || zSettings.downloadbootgen
    fprintbf("Do you want to download and install bootgen locally? [Y/n]")
    answer = input("", 's');
    switch answer
        case {'Y', 'y', ''}
            downloadBootgen(); checkDependencies(); return;
        otherwise
            warning("bootgen is needed to generate the SD image." + ...
                "You can generate the makefiles and the Simulink block, " + ...
                "but you cannot generate the BOOT.bin image to be uploaded.");
    end
end

end