function totSize = getTotalTreeSize(fullInputStruct)
%GETTOTALTREESIZE Summary of this function goes here
%   Detailed explanation goes here

totSize = 0;
for j=1:numel(fullInputStruct)
    if not(isnan(fullInputStruct(j).Size))
        thisTreeSize = fullInputStruct(j).Size;
    else
        thisTreeSize = 0;
        for k=1:numel(fullInputStruct(j).Children)

        thisTreeSize = thisTreeSize + getTotalTreeSize(fullInputStruct(j).Children(k));
        end
    end
            totSize = totSize + thisTreeSize;

end


end
