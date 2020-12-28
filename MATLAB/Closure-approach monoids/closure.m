function [closedSub] = closure(x,y,numElements)
%CLOSURE Find the closure of two submonoids
%   Takes two submonoid arrays X = X' ∪ Core and Y = Y' ∪ Core, and returns
%   X ∪ Y ∪ X'Y' ∪ X'Y'X' ∪ X'Y'X'Y' ∪ ... ∪ Y'X' ∪ Y'X'Y' ∪ Y'X'Y'X' ∪ ...
%   Core = X ∩ Y, X' = X - Core, Y' = Y - Core.

validCombos = allValidCombos(numElements);
id = identity(numElements);

xp = setdiff(x,y);
yp = setdiff(y,x);

if(isempty(xp))
    xpsize = 0;
else
    xpsize = size(xp,2);
end
if(isempty(yp))
    ypsize = 0;
else
    ypsize = size(yp,2);
end

closedSub = [xp,y];
xpyp = id * ones(1,xpsize*ypsize);
for i=1:1:xpsize
    for j=1:1:ypsize
        comp1 = compositionZeroBased(validCombos(xp(i),1:end),validCombos(yp(j),1:end));
        [~, index1] = ismember(comp1,validCombos,'rows');
        xpyp(1,(i-1)*ypsize + j) = index1;
    end
end
xpyp = setdiff(unique(xpyp),closedSub);
closedSub = [closedSub,xpyp];
toCompose = [xpyp,yp];

while(true)
    if(isempty(toCompose))
        break;
    else
        tCSize = size(toCompose,2);
    end
    
    compCycle = id * ones(1,tCSize * xpsize);
    
    for i = 1:1:tCSize
        for j = 1:1:xpsize
            comp1 = compositionZeroBased(validCombos(toCompose(i),1:end),validCombos(xp(j),1:end));
            [~, index1] = ismember(comp1,validCombos,'rows');
            compCycle(1,(i-1) * xpsize + j) = index1;
        end
    end
    
    compCycle = setdiff(unique(compCycle),closedSub);
    closedSub = [closedSub, compCycle];
    toCompose = compCycle;
    if(isempty(toCompose))
        closedSub = sort(closedSub);
        break;
    else
        tCSize = size(toCompose,2);
    end
    
    compCycle = id * ones(1,tCSize * ypsize);
    for i = 1:1:tCSize
        for j = 1:1:ypsize
            comp1 = compositionZeroBased(validCombos(toCompose(i),1:end),validCombos(yp(j),1:end));
            [~, index1] = ismember(comp1,validCombos,'rows');
            compCycle(1,(i-1) * ypsize + j) = index1;
        end
    end
    compCycle = setdiff(unique(compCycle),closedSub);
    closedSub = [closedSub, compCycle];
    toCompose = compCycle;
end

closedSub = sort(closedSub);
end

