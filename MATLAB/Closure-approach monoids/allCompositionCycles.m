clear;
clc;

%Number of elements in transformation monoid
numElements = 4;
%Largest transformation monoid size wanted
%maxsize = numMappings;
maxsize = 6;

%Number of possible mappings of elements
numMappings = numElements^numElements;
%Actual table of all mappings
validCombos = allValidCombos(numElements);
%All compositions of mappings
table = compositionTable(numElements);

%All families generated by singular elements (and identity)
cyclicFamilies = cell(1,size(validCombos,1));
%Produce default array whose rows are all identity)
onesColumn = ones(landau(numElements),1);
identityRow = validCombos(identity(numElements),1:end);
defaultArray = onesColumn * identityRow;
%Generate family from each mapping
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
    for i = 2:1:numMappings
        for j = 1:1:size(submonoidTables,2)-1
            for k = 1:1:size(submonoidTables{i,j},2)
               for m = 1:1:numMappings
                   for n = 1:1:size(submonoidTables{m,end-1},2)
                        product = closure(submonoidTables{i,j}{1,k},submonoidTables{m,end-1}{n},numElements,table);
                        prodsize = size(product,2);
                        if(prodsize <= maxsize)
                            [logic,submonoidTables{prodsize,end}] = inclusionDiff(submonoidTables{prodsize,end}, product);
                            if logic == 1
                                discontinueLoop = 0;
                            end
                        end
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

%Print out all found monoids
for i = 1:1:maxsize
    sizeI = 0;
    for j = 1:1:size(submonoidTables,2)
        if(isempty(submonoidTables(i,j)))
            specificSize = 0;
        else
            specificSize = size(submonoidTables{i,j},2);
        end
        sizeI = sizeI + specificSize;
    end
    disp([num2str(i),': ',num2str(sizeI)]);
end