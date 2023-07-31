function [updatedInputStruct, totSize]= getTotalTreePaddedSize(fullInputStruct)
%GETTOTALTREESIZE Summary of this function goes here
%   Detailed explanation goes here
updatedInputStruct = fullInputStruct;
totSize = 0;
for j=1:numel(fullInputStruct)
    if not(isnan(fullInputStruct(j).Size))
        thisTreeSize = fullInputStruct(j).Size;
    else
        thisTreeSize = 0;
        for k=1:numel(fullInputStruct(j).Children)
            [newChildren, ChildrenSize] = getTotalTreePaddedSize(fullInputStruct(j).Children(k));
            updatedInputStruct.Children(k) = newChildren;
           thisTreeSize = thisTreeSize + ChildrenSize;
        end
        updatedInputStruct(j).Size = thisTreeSize;

        
    end

    if mod(thisTreeSize, 8) > 0
        % We need padding
        updatedInputStruct(j).Padding = ceil(thisTreeSize/8) * 8 - thisTreeSize; 
    end
    totSize = totSize + ceil(thisTreeSize/8) * 8;
    
end


end
