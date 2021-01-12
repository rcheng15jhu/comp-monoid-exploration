clear;
clc;

numMonoids = 2;

results = cell(1,0);
indices = zeros(1,(numMonoids - 1)^2);
maxIndices = (numMonoids - 1) * ones(1,(numMonoids - 1)^2);
while(true)
    if(testConsistency(reshape(indices,[numMonoids-1,numMonoids-1]),0) == 1)
        results{1,end+1} = reshape(indices,[numMonoids-1,numMonoids-1]);
    end
    if(~isequal(indices, maxIndices))
        indices = oldCycleArray(indices,numMonoids);
    else
        break
    end
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