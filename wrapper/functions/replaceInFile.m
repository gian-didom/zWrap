function replaceInFile(filepath, original, replacement, savepath)
% replaceInFile - strrep over an entire file, in-place
if nargin == 3
    savepath = filepath;
end

assert(isfile(filepath), "File not found");

text = fileread(filepath);
text = strrep(text, original, replacement);

fid = fopen(savepath, 'w');
assert(fid > -1, "Error opening file for writing, check permissions and paths.");
fprintf(fid, "%s", text);
fclose(fid);


end