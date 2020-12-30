function [table] = compositionTable(validCombos)
%COMPOSITIONTABLE Summary of this function goes here
%   Detailed explanation goes here

table = zeros(size(validCombos,1),size(validCombos,1));
for i = 1:1:size(validCombos,1)
    for j = 1:1:size(validCombos,1)
        [~,table(i,j)] = ismember(compositionZeroBased(validCombos(i,1:end),validCombos(j,1:end)),validCombos,'rows');
    end
end

end

