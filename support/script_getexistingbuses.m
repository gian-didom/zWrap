% Get all variables names of existing bus elements that are not in the
% newly created buses
wsVars = whos;
busVars = wsVars(strcmp({wsVars.class}, 'Simulink.Bus'));
for j=1:numel(busVars)
    existingBusVars.(busVars(j).name) = eval(busVars(j).name);
end
% I am saving the existing bus variables in a structure, so that when I
% create the new bus, overwritten buses can still be accessed since they
% are stored in the structure
existingBusVarNames = fields(existingBusVars);


% Now create the new buses