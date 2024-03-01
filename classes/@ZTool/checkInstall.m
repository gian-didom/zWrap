% ========================================================================
% Check interface
function checkInstall(obj)
execFile = obj.execFile();


% Attempt 1: Look for the tool in custom paths
% Check if the tool has been assigned a custom path
if obj.hasCustomPath()
    toolpath = fullfile(obj.getCustomPath(), execFile);
    if isfile(toolpath)
        tmp = what(toolpath);
        obj.path = tmp.path; obj.execpath = fullfile(obj.path, execFile);
        fprintf("%s found at %s\n", obj.name, obj.execpath);
        return;
    else
        warning("Custom path for %s does not exist. Trying default paths.", obj.name);
    end
end


% Attempt 2: Look for the tool in local tool folder
% Check if the tool is in the local tool folder
localTool = fullfile("tools", obj.foldername, execFile);
if isfile(localTool)
    tmp = what(localTool);
    obj.path = tmp.path; obj.execpath = fullfile(obj.path, execFile);
    fprintf("%s found at %s\n", obj.name, obj.execpath);
    return;
end


% Attempt 3: Look for the tool in system paths
% Check if the tool is in global paths
uniquePathList = obj.getPossibleToolPaths();
% Check for the execFile in all possible tool paths
foundExec = cellfun(@(x) isfile(fullfile(x, execFile)), uniquePathList);
if not(any(foundExec))
    obj.fail("%s not found. Please install from official sources. ", obj.name);
    obj.path = false;
    obj.execpath = false;
    return
end

% Note: any other check should be done in the subclasses

end

