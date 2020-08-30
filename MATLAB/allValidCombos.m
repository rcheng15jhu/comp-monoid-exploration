function [array] = allValidCombos(size)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    tempArray = zeros(size^size,size);
    currentRow = zeros(1,size);
    for(i = 2:1:size^size)
        currentRow = cycleArrayBase(currentRow,size,0);
        tempArray(i,1:end) = currentRow;
    end
    array = tempArray;
end

