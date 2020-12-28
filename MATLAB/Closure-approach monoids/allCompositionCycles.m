clear;
clc;

numElements = 3;
numMappings = numElements^numElements;
table = compositionTable(numElements);
%maxsize = 6;
validCombos = allValidCombos(numElements);
cyclicFamilies = cell(1,size(validCombos,1));

onesColumn = ones(landau(numElements),1);
identityRow = validCombos(identity(numElements),1:end);
defaultArray = onesColumn * identityRow;
for i = 1:1:size(validCombos,1)
    powers = defaultArray;
    seed = validCombos(i,1:end);
    check = 0;
    j = 0;
    while(check == 0)
        j = j + 1;
        powers(j,1:end) = seed;
        [~, index] = ismember(seed,validCombos,'rows');
        cyclicFamilies{i} = [cyclicFamilies{i}, index];
        seed = compositionZeroBased(validCombos(i,1:end),seed);
        check = ismember(seed,powers,'rows');
    end
    cyclicFamilies(i) = {sort([setdiff(cyclicFamilies{i},identity(numElements)),identity(numElements)])};
end
cyclicFamilies = redundantCell(cyclicFamilies);

submonoidTables = cell(0,0);
for i = 1:1:numMappings
    submonoidTables{i,1} = cell(0,0);
end
for i = 1:1:size(cyclicFamilies,2)
    submonoidTables{size(cyclicFamilies{i},2),1}{end+1} = cyclicFamilies{i};
end

compOfFamilies = cell(1,0);
discontinueLoop = 0;
while(~discontinueLoop)
    discontinueLoop = 1;
    tempSize = size(submonoidTables,2)+1;
    submonoidTables(1:end,end+1) = cell(numMappings,1);
    for i = 1:1:numMappings
        for j = 1:1:size(submonoidTables,2)-1
            for k = 1:1:size(submonoidTables{i,j},2)
               for m = 1:1:numMappings
                   for n = 1:1:size(submonoidTables{m,end-1},2)
                        product = closure(submonoidTables{i,j}{1,k},submonoidTables{m,end-1}{n},numElements,table);
                        prodsize = size(product,2);
                        %if(prodsize <= maxsize)
                            [logic,submonoidTables{prodsize,end}] = inclusionDiff(submonoidTables{prodsize,end}, product);
                            if logic == 1
                                discontinueLoop = 0;
                            end
                        %end
                   end
                end
            end
        end
    end
    
    for i = 1:1:numMappings
        for j = 1:1:size(submonoidTables,2)-1
            for k = 1:1:size(submonoidTables{i,j},2)
                for m = size(submonoidTables{i,end},2):-1:1
                    if(isequal(submonoidTables{i,j}{k},submonoidTables{i,end}{m}))
                        submonoidTables{i,end} = submonoidTables{i,end}([1:m-1 m+1:end]);
                    end
                end
            end
        end
    end
end

submonoidTables = submonoidTables(1:end,1:end-2);