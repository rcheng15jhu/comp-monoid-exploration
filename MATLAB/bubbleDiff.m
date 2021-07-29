function [logic_difference,newCell] = bubbleDiff(cell,set)
%BUBBLEDIFF Check if a set is present within a cell of sets
    %Return cell + set, logic_difference = 1 if set is not in cell.

s = size(cell,2);
if(s == 0)
    logic_difference = 1;
    newCell = {set};
else
    counter = 1;
    while counter <= s
        comp = arrayComp(cell{counter},set);
        if comp == 0
            logic_difference = 0;
            newCell = cell;
            if(counter > 1)
                k = cell{counter-1};
                cell{counter-1} = cell{counter};
                cell{counter} = k;
            end
            return
        end
        counter = counter + 1;
    end
    
    logic_difference = 1;
    newCell = {cell{[1:end]},set};
end

end

