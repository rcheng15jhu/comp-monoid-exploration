function [table] = closureTable(numElem,compTable)
%CLOSURETABLE Summary of this function goes here
%   Detailed explanation goes here

numMaps = numElem^numElem;
table = cell(numMaps,numMaps);
for i = 1:1:numMaps
    for j = i:1:numMaps
        table{i,j} = closure([i],[j],compTable,numMaps,identity(numElem));
    end
end

end

