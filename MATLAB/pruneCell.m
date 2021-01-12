function [prunedSet] = pruneCell(keyCell,toPrune)
%PRUNECELL Takes two SORTED cells and prunes one of all common elements.
%   Takes a climbing ladder approach, akin to set difference (fastSetDiff.)

i = 1;
j = 1;
while i <= size(keyCell,2) && j <= size(toPrune,2)
    comp = arrayComp(keyCell{1,i},toPrune{1,j});
    if(comp == -1)
        i = i+1;
    elseif (comp == 1)
        j = j+1;
    else
        toPrune = toPrune([1:j-1,j+1:size(toPrune,2)]);
        i = i+1;
    end
end
prunedSet = toPrune;

end

