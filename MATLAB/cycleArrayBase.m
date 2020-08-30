function [cycledArray] = cycleArrayBase(array,base,checkDec)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
array(1,end) = array(1,end) + 1;
tempArray = array;

if(checkDec)
    dec = (tempArray <= [tempArray([2:end]),tempArray(end)+1]);
    if(any(dec == 0))
        decIndex = find(dec == 0);
        tempArray(1,(decIndex(1)+1):end) = tempArray(1,decIndex(1));
    end
end

array = tempArray;
while(any(any(array >= base)))
    greaterThanBase = find(array >= base);
    tempArray(greaterThanBase - 1) = tempArray(greaterThanBase - 1) + 1;
    tempArray(greaterThanBase) = tempArray(greaterThanBase) - base;
    array = tempArray;
end

cycledArray = tempArray;

end

