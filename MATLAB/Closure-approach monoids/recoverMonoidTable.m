function [monoidTable] = recoverMonoidTable(oldTable)
%RECOVERMONOIDTABLE Summary of this function goes here
%   Detailed explanation goes here
maxSize = size(oldTable,1);
monoidTable = cell(maxSize,1);
for i = 1:1:maxSize
    iCell = cell(1,0);
    for j = 1:1:size(oldTable,2)
        for k = 1:1:size(oldTable{i,j},2)
            for m = 1:1:size(oldTable{i,j}{k},2)
                [~,iCell] = inclusionDiff(iCell,oldTable{i,j}{k}{m});
            end
        end
    end
    monoidTable{i} = iCell;
end

end

