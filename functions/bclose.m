function tag = bopen()
    if (desktop('-inuse'))
        tag = "</strong>";
    else
        % Close terminal tag for bold
        tag = "\033[0m";
    end
    
end