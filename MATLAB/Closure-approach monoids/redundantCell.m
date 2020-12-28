function [nonredundantCell] = redundantCell(processedCell)
%REDUNDANTCELL Remove all redundant elements from a row cell
redundantIndices = cell(1,0);
for i = 1:1:size(processedCell,2)-1
    for j = i+1:1:size(processedCell,2)
        if(isequal(processedCell{1,i},processedCell{1,j}))
            redundantIndices{size(redundantIndices,2)+1} = j;
        end
    end
end
redundantArray = unique(cell2mat(redundantIndices));
total = find(ones(1,size(processedCell,2)) == 1);
finalIndices = setdiff(total,redundantArray);
nonredundantCell = processedCell(finalIndices);

end

