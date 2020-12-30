function [logic_difference,newCell] = inclusionDiff(cell,set)
%CELLDIFF Check if a set is present within a cell of sets
    %Return cell + set, logic_difference = 1 if set is not in cell.

s = size(cell,2);
if(s == 0)
    logic_difference = 1;
    newCell = {set};
else
    counter = 1;
    while counter <= s
        comp = arrayComp(cell{counter},set);
        if comp ~= -1
            break;
        else
            counter = counter+1;
        end
    end

    if(comp == 0)
        logic_difference = 0;
        newCell = cell;
    else
        logic_difference = 1;
        newCell = {cell{[1:counter-1]},set,cell{[counter:end]}};
    end
end

end

