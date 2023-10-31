function buildProjectDir(fcnName, targetFolderName, packDir, iss, oss)
global zEnv

% 2. Add the "zed" folder to the project folder
copyfile(fullfile("boards", "zedboard", "bsp", "zed", "*"), ...
    fullfile(targetFolderName, "project", "zed"));

% 4. Add the {{fcnName}}_core1 folder (MATLAB function)
copyfile(fullfile("boards", "zedboard", "bsp", "app_core0", "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_core0", fcnName)));

% 4. Add the {{fcnName}}_core1 folder (MATLAB function)
copyfile(fullfile("boards", "zedboard", "bsp", "app_core1", "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_core1", fcnName)));

% 5. Add the {{fcnName}}_multicore_system folder
copyfile(fullfile("boards", "zedboard", "bsp", "app_multicore_system", "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_multicore_system", fcnName)));

% 6. Move the contents of the "pack" directory in the {{fncName}}_core1/src folder
copyfile(fullfile(packDir, "*"), ...
    fullfile(targetFolderName, "project", sprintf("%s_core1", fcnName), "src"));

% 7. Move the memory mapping file to the proper directory
copyfile(fullfile(targetFolderName, "generated", "memorymap.h"), ...
        fullfile(targetFolderName, ...
            "project", ...
            sprintf("%s_multicore_system", fcnName), ...
            'include_common'));

% 7. Move the Cpp calling function to the proper directory
copyfile(fullfile(targetFolderName, "generated", "callFunction.c"), ...
        fullfile(targetFolderName, ...
            "project", ...
            sprintf("%s_core1", fcnName), ...
            'src'));

copyfile(fullfile(targetFolderName, "generated", "callFunction.h"), ...
        fullfile(targetFolderName, ...
            "project", ...
            sprintf("%s_core1", fcnName), ...
            'src'));


% Create the fname.mk file in the folder
mkString = sprintf("FUNCTION_NAME = %s", fcnName);
fid = fopen(fullfile(targetFolderName, 'project', "fname.mk"), "w");
fprintf(fid, mkString);
fclose(fid);

% Create the compiler.mk file in the folder
mkString = sprintf("ARM_GCC = %s\nARM_GPP = %s", strrep(zEnv.armGppBin, 'g++', 'gcc'), zEnv.armGppBin);
fid = fopen(fullfile(targetFolderName, 'project', "compiler.mk"), "w");
fprintf(fid, mkString);
fclose(fid);

%% Generate Linker script
generateLinkerScript(fcnName, targetFolderName, iss, oss);
end