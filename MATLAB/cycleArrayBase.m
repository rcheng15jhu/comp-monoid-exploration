function [cycledArray] = cycleArrayBase(array,base,invalid)
%Cycles an array based on a given base.
%Different from oldCycleArray, which does not preserve monotonicity.
tempArray = array;
tempArray(1,end) = tempArray(1,end) + 1;

%Note that >=: the reason why this is is because we cycle from 0 to n - 1
%rather than from 1 to n.
while(any(any(tempArray >= base)))
    greaterThanBase = find(tempArray >= base);
    for i = 1:1:size(greaterThanBase,2)
        tempArray(greaterThanBase(1,i) - 1) = tempArray(greaterThanBase(1,i) - 1) + 1;
        tempArray(greaterThanBase(1,i)) = tempArray(greaterThanBase(1,i) - 1);
    end
    tempArray(1,end) = tempArray(1,end) + 1;
end

while(any(invalid == tempArray(1,1)))
    tempArray = find(zeros(1,size(tempArray,2)) == 0) + tempArray(1,1);
end

cycledArray = tempArray;

end

