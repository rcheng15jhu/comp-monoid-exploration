function [logic_difference,newCell] = sortedDiff(cell,set)
%CELLDIFF Check if a set is present within a sorted cell of sets
    %Return cell + set, logic_difference = 1 if set is not in cell.

s = size(cell,2);
if(s == 0)
    logic_difference = 1;
    newCell = {set};
else
    lowball = 1;
    highball = s;
    
    firstCheckLow = arrayComp(cell{lowball},set);
    if(firstCheckLow == 0)
        logic_difference = 0;
        newCell = cell;
        return;
    elseif(firstCheckLow == -1)
        logic_difference = 1;
        newCell = {set,cell{[1:end]}};
        return;
    end
    
    firstCheckHigh = arrayComp(cell{highball},set);
    if(firstCheckHigh == 0)
        logic_difference = 0;
        newCell = cell;
        return;
    elseif(firstCheckHigh == 1)
        logic_difference = 1;
        newCell = {cell{[1:end]},set};
        return;
    end
    
    while(lowball < highball - 1)
        mid = floor((lowball + highball)/2);
        check = arrayComp(cell{mid},set);
        if(check == 0)
            logic_difference = 0;
            newCell = cell;
            return;
        elseif(check == 1)
            lowball = mid;
        else
            highball = mid;
        end
    end
    
    logic_difference = 1;
    newCell = {cell{[1:lowball]},set,cell{[highball:end]}};
    return;
end

end

