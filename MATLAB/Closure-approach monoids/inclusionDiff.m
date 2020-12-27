function [newCell,logic_difference] = inclusionDiff(cell,set)
%CELLDIFF Check if a set is present within a cell of sets
    %Return cell + set, logic_difference = 1 if set is not in cell.

logic_difference = 1;
for i = 1:1:size(cell,2)
    if(isequal(cell{i},set))
        logic_difference = 0;
        break;
    end
end

newCell = cell;

if(logic_difference == 1)
    newCell{size(cell,2)+1} = set;
end

end

