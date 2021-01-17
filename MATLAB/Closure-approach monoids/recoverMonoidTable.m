function [monoidTable] = recoverMonoidTable(oldTable)
%RECOVERMONOIDTABLE Summary of this function goes here
%   Detailed explanation goes here
maxSize = size(oldTable,1);
monoidTable = cell(1,1);
for i = 1:1:maxSize
    for j = 1:1:size(oldTable,2)
        ijCell = cell(1,0);
        for k = 1:1:size(oldTable{i,j},2)
            for m = 1:1:size(oldTable{i,j}{k},2)
                [~,ijCell] = inclusionDiff(ijCell,oldTable{i,j}{k}{m});
            end
        end
        monoidTable{i,j} = ijCell;
    end
end

end

