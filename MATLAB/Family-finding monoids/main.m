clear;
clc;

numMonoids = 4;

results = cell(1,0);
indices = zeros(1,(numMonoids - 1)^2);
maxIndices = (numMonoids - 1) * ones(1,(numMonoids - 1)^2);
while(~isequal(indices, maxIndices))
    if(testConsistency(reshape(indices,[numMonoids-1,numMonoids-1]),0) == 1)
        results{1,end+1} = reshape(indices,[numMonoids-1,numMonoids-1]);
    end
    indices = oldCycleArray(indices,numMonoids);
end
clearvars indices maxIndices

nonIsoFams = cell(1,0);
while(size(results,2) ~= 0)
    allIso = iso(results{1});
    nonIsoFams{1,end+1} = allIso{1,1};
    results = pruneCell(allIso,results);
end
clearvars allIso results
for i = 1:1:size(nonIsoFams,2)
    disp(nonIsoFams{1,i});
end
clearvars i

function [isomorphs] = iso(combo)
    numElements = size(combo,1);
    permutations = perms(1:numElements);
    isomorphs = cell(1,0);
    curIso = combo;
    for p = 1:1:size(permutations,1)
        for i = 1:1:size(combo,1)
            for j = 1:1:size(combo,2)
                if combo(i,j) ~= 0
                    curIso(permutations(p,i),permutations(p,j)) = permutations(p,combo(i,j));
                else
                    curIso(permutations(p,i),permutations(p,j)) = 0;
                end
            end
        end
        [~,isomorphs] = inclusionDiff(isomorphs,curIso);
    end
end