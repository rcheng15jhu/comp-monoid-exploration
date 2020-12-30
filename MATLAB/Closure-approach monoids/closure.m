function [closedSub] = closure(x,y,table,maxsize,id)
%CLOSURE Finds the fast-closure of two submonoids
%   Takes two submonoid arrays X = X' U Core and Y = Y' U Core, and returns
%   Core U X' U X'Y' U X'Y'X' U X'Y'X'Y' U ... U Y' U Y'X' U Y'X'Y' U Y'X'Y'X' U ...
%   Core = X intersect Y, X' = X - Core, Y' = Y - Core.

[xp,yp,closedSub,xpsize,ypsize] = fastSetDiff(x,y);
if(size(closedSub,2) <= maxsize && size(xp,2) ~= 0 && size(yp,2) ~= 0)
    xpyp = id * ones(1,xpsize*ypsize);
    for i=1:1:xpsize
        for j=1:1:ypsize
            xpyp(1,(i-1)*ypsize + j) = table(xp(i),yp(j));
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
                compCycle(1,(i-1) * xpsize + j) = table(toCompose(i),xp(j));
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
                compCycle(1,(i-1) * ypsize + j) = table(toCompose(i),yp(j));
            end
        end
        compCycle = setdiff(unique(compCycle),closedSub);
        closedSub = [closedSub, compCycle];
        toCompose = compCycle;
    end
    closedSub = sort(closedSub);
else
    closedSub = zeros(1,maxsize + 1);
end

end

