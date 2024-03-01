function [outputArg1,outputArg2] = generateLinkerScript(fcnName, targetFolderName, iss, oss)
global zSettings
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
VECTOR_TABLE_ALIGN = 2048;

MAX_MEM = 512*1024*1024;    % Max memory available on platform [bytes]

O0 = 1024*1024;  % Beginning of core0's dedicated memory
L0 = 5*1024*1024;  % Default core0 dedicated memory

OS = O0+L0;    % Start shared memory right after core0 memory
LS = iss.getTotalSizePadded + oss.getTotalSizePadded;

O1 = ceil((OS+LS)/VECTOR_TABLE_ALIGN)*VECTOR_TABLE_ALIGN;         % Beginning of Core1 Memory - pad to 32 bit.
L1 = MAX_MEM - O1;               % Length of Core1 Memory

STACKSIZE0 = 8192;  % 0x2000
HEAPSIZE0 = 8192;   % 0x2000

STACKSIZE1 = zSettings.stack;
HEAPSIZE1 = zSettings.heap;

fprintf("\n<strong>Memory configuration:</strong>\n");
fprintf("ARM0 start address:\t %s\tlength: %s\n", dec2hex(O0,8), dec2hex(L0,8));
fprintf("I/O start addresst\t %s\tlength: %s\n", dec2hex(OS,8), dec2hex(LS,8));
fprintf("ARM1 start address:\t %s\tlength: %s\n", dec2hex(O1,8), dec2hex(L1,8));
fprintf("ARM0 Heap Size: \t %i\tstack: %i\n", HEAPSIZE0, STACKSIZE0);
fprintf("ARM1 Heap Size: \t %i\tstack: %i\n", HEAPSIZE1, STACKSIZE1);

%% Customize linker script for core0
ld0_path = fullfile(targetFolderName, "project", sprintf("%s_core0", fcnName), "src", "lscript.ld");
replaceInFile(ld0_path, ...
    {"{{DDR0_START_CORE0}}", "{{DDR0_LENGTH_CORE0}}", "{{DDR_SHARED_START}}", "{{DDR_SHARED_LENGTH}}", "{{STACKSIZE_CORE0}}", "{{HEAPSIZE_CORE0}}"}, ...
    {hexpre(O0), hexpre(L0), hexpre(OS), hexpre(LS), hexpre(STACKSIZE0), hexpre(HEAPSIZE0)});

%% Customize linker script for core1
ld1_path = fullfile(targetFolderName, "project", sprintf("%s_core1", fcnName), "src", "lscript.ld");
replaceInFile(ld1_path, ...
    {"{{DDR0_START_CORE1}}", "{{DDR0_LENGTH_CORE1}}", "{{DDR_SHARED_START}}", "{{DDR_SHARED_LENGTH}}", "{{STACKSIZE_CORE1}}", "{{HEAPSIZE_CORE1}}"}, ...
    {hexpre(O1), hexpre(L1), hexpre(OS), hexpre(LS), hexpre(STACKSIZE1), hexpre(HEAPSIZE1)});

%% Set define for I/O memory region start
iomem_mk_path = fullfile(targetFolderName, "project", "iomem.mk");
fid = fopen(iomem_mk_path, 'w');
fprintf(fid, 'IO_BASE_ADDR = %s', hexpre(OS));
fclose(fid);

end

function replaceInFile(file, before, after)
    fid = fopen(file, 'r');
    fc = fscanf(fid, '%c');
    fc_new = fc;
    if iscell(before)

        assert(iscell(after), "Only string-string or cell-cell inputs are foreseen.");
        assert(numel(before) == numel(after), "The number of strings to find and the replace values must be equal");

        for j=1:numel(before)
            fc_new = strrep(fc_new, before{j}, after{j});
        end
    else
        fc_new = strrep(fc_new, before, after);
    end

    fclose(fid);

    % Open for writing
    fid_w = fopen(file, 'w');
    fprintf(fid_w, '%c', char(fc_new));
    fclose(fid_w);
end

function hexpre = hexpre(dec)
    hexpre = sprintf("0x%s", dec2hex(dec,8));
end