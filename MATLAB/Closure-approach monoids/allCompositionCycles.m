clear;
clc;

numElements = 3;
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
        [logic, index] = ismember(seed,validCombos,'rows');
        cyclicFamilies{i} = [cyclicFamilies{i}, index];
        seed = compositionZeroBased(validCombos(i,1:end),seed);
        check = ismember(seed,powers,'rows');
    end
    cyclicFamilies(i) = {sort([setdiff(cyclicFamilies{i},identity(numElements)),identity(numElements)])};
end
cyclicFamilies = redundantCell(cyclicFamilies);

submonoidTables = {cyclicFamilies};
compOfFamilies = cell(1,0);
discontinueLoop = 0;
while(~discontinueLoop)
    discontinueLoop = 1;
    for i = 1:1:size(submonoidTables,2)
        for j = 1:1:size(submonoidTables{i},2)
            for k = 1:1:size(submonoidTables{end},2)
                product = closure(submonoidTables{i}{j},submonoidTables{end}{k},numElements);
                [compOfFamilies,logic] = inclusionDiff(compOfFamilies, product);
                if logic == 1
                    discontinueLoop = 0;
                end
            end
        end
    end
    
    checkRedundancy = cell(1,0);
    for k = 1:1:size(compOfFamilies,2)
        add = 0;
        for i = 1:1:size(submonoidTables,2)
            for j = 1:1:size(submonoidTables{i},2)
                if(isequal(submonoidTables{i}{j},compOfFamilies{k}))
                    add = 1;
                end
                if(add == 1)
                    break;
                end
            end
            if(add == 1)
                break;
            end
        end
        if(add == 0)
            checkRedundancy{size(checkRedundancy,2)+1} = compOfFamilies{k};
        end
    end
    submonoidTables{size(submonoidTables,2)+1} = checkRedundancy;
end

finalTable = zeros(numElements^numElements,1);
for i = 1:1:size(compOfFamilies,2)
    finalTable(size(compOfFamilies{i},2)) = finalTable(size(compOfFamilies{i},2)) + 1;
end
for i = 1:1:size(finalTable,1)
    disp([num2str(i),': ',num2str(finalTable(i))]);
end
