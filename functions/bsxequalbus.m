
function out = bsxequalbus(bus1, bus2)

if (numel(bus1.Elements) ~= numel(bus2.Elements))
   % Then they are different for sure.
    out = false;
    return;
end

equalmat = zeros(numel(bus1.Elements));
for j=1:numel(bus1.Elements)
    for k=1:numel(bus2.Elements)
        equalmat(j,k) = isequal(bus1.Elements(j), bus2.Elements(k));
    end
end

% Check if matrix is full rank
if (rank(equalmat) < numel(bus1.Elements))
    out = false;
    return
end

% If rank is full, we have a correspondence

if (isequal(equalmat*equalmat', eye(numel(bus1.Elements))))
    % Should be ok!
    out = true;
end