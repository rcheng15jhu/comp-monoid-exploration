function [closedSub] = closure(submonoid1,submonoid2,numElements)
%CLOSURE Find the closure of two submonoids
%   Detailed explanation goes here

validCombos = allValidCombos(numElements);

newsub1 = setdiff(submonoid1,submonoid2);
newsub2 = setdiff(submonoid2,submonoid1);

if(isempty(newsub1))
    sizesub1 = 0;
else
    sizesub1 = size(newsub1,2);
end
if(isempty(newsub2))
    sizesub2 = 0;
else
    sizesub2 = size(newsub2,2);
end

closedSub = [newsub1,submonoid2];
toBeAdded = [];
for i=1:1:sizesub1
    for j=1:1:sizesub2
        comp1 = compositionZeroBased(validCombos(newsub1(i),1:end),validCombos(newsub2(j),1:end));
        [logic, index1] = ismember(comp1,validCombos,'rows');
        toBeAdded = [toBeAdded,index1];
        
        comp2 = compositionZeroBased(validCombos(newsub2(j),1:end),validCombos(newsub1(i),1:end));
        [logic, index2] = ismember(comp2,validCombos,'rows');
        toBeAdded = [toBeAdded,index2];
    end
end
toBeAdded = setdiff(unique(toBeAdded),closedSub);
closedSub = [closedSub,toBeAdded];

check = 1;
while(check)
    compCycle = [];
    
    if(isempty(toBeAdded))
        toBeAddedSize = 0;
    else
        toBeAddedSize = size(toBeAdded,2);
    end
    
    if(isempty(closedSub))
        closedSubSize = 0;
    else
        closedSubSize = size(closedSub,2);
    end
    
    for i = 1:1:toBeAddedSize
        for j = 1:1:closedSubSize
            comp1 = compositionZeroBased(validCombos(toBeAdded(i),1:end),validCombos(closedSub(j),1:end));
            [logic, index1] = ismember(comp1,validCombos,'rows');
            compCycle = [compCycle,index1];
        
            comp2 = compositionZeroBased(validCombos(closedSub(j),1:end),validCombos(toBeAdded(i),1:end));
            [logic, index2] = ismember(comp2,validCombos,'rows');
            compCycle = [compCycle,index2];
        end
    end
    compCycle = setdiff(unique(compCycle),closedSub);
    closedSub = [closedSub, compCycle];
    toBeAdded = compCycle;
    check = ~isempty(compCycle);
end
closedSub = sort(closedSub);

end

