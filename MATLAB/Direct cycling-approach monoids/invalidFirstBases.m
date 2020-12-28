function [invalidBases,cycles] = invalidFirstBases(mapTable,loops,cyclesize)
%Returns a list of numbers that cannot be the smallest mapping in a
%submonoid (since one of the powers is lower in order than the mapping.)
array = zeros(1,size(mapTable,1));
findcyc = zeros(1,size(mapTable,1));
identity = find(zeros(1,size(mapTable,2)) == 0) - 1;
for i = 1:1:size(mapTable,1)
    curPower = mapTable(i,1:end);
    for j = 1:1:loops
        curPower = compositionZeroBased(curPower, mapTable(i,1:end));
        
        if(all(curPower == identity))
            if(j == cyclesize)
                findcyc(1,i) = 1;
            end
            break;
        end
        
        if(arrayLess(curPower,mapTable(i,1:end)))
            array(1,i) = 1;
        end
    end
end

array = find(array == 1);
findcyc = find(findcyc == 1);
invalidBases = array;
cycles = findcyc;