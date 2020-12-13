function [array] = allValidCombos(size)
%Return all valid mappings of given size (e.g. 2443 or 14523)
    tempArray = zeros(size^size,size);
    currentRow = zeros(1,size);
    for i = 2:1:size^size
        currentRow = oldCycleArray(currentRow,size);
        tempArray(i,1:end) = currentRow;
    end
    array = tempArray;
end

