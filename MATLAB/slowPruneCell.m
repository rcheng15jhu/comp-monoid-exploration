function [prunedCell] = slowPruneCell(keyPrune,toPrune)
%SLOWPRUNECELL Summary of this function goes here
%   Detailed explanation goes here
for i = 1:1:size(keyPrune,2)
    for j = size(toPrune,2):-1:1
        if isequal(keyPrune{i},toPrune{j})
            toPrune = toPrune([1:j-1,j+1:end]);
        end
    end
end
prunedCell = toPrune;
end

