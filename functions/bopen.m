function tag = bopen()
if (desktop('-inuse'))
    tag = "<strong>";
else
    % Use terminal tag
    tag = "\033[1m";
end

end