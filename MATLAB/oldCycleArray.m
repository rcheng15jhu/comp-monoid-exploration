function [cycledArray] = oldCycleArray(array,base)
%Cycles an array based on a given base with no regard to monotonicity.
array(1,end) = array(1,end) + 1;
tempArray = array;

%checkDec checks if any of the array is decreasing.
%Can be improved.
array = tempArray;
while(any(any(array >= base)))
    greaterThanBase = find(array >= base);
    tempArray(greaterThanBase - 1) = tempArray(greaterThanBase - 1) + 1;
    tempArray(greaterThanBase) = tempArray(greaterThanBase) - base;
    array = tempArray;
end

cycledArray = tempArray;

end

