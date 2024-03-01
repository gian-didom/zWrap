
for j=1:numel({{BUSNAME}})
    thisBus = eval({{BUSNAME}}{j}{1});
    % Check correspondence with existing buses
    for ks = 1:numel(existingBusVarNames)
        existingBus = existingBusVars.(existingBusVarNames{ks});
        if bsxequalbus(thisBus, existingBus)
            fprintf("Found equality between %s and %s. Replacing...\n", ...
                {{BUSNAME}}{j}{1}, existingBusVarNames{ks})
             assignin("caller", {{BUSNAME}}{j}{1}, existingBus);
            break;
        end
    end
end

