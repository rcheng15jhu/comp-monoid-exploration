%Main function: this is the 'control' panel for finding submonoids.
clear;
clc;

%Somewhat confusingly named; this is the number of elements within each
%mapping (e.g. 5 for 11244, 3 for 132.)
monoidsize = 4;
%Number of mappings within each submonoid.
submonoidsize = 6;
validCombos = allValidCombos(monoidsize);

identityNum = (monoidsize^monoidsize - monoidsize)/(monoidsize - 1)^2;
identity = validCombos(identityNum,1:end);
%Excise identity element.
validCombos = validCombos([1:identityNum-1,identityNum+1:end],1:end);
maxbound = (find(zeros(1,submonoidsize - 1) == 0)) + (monoidsize^monoidsize - submonoidsize - 1);

[invalidBases, cycles] = invalidFirstBases(validCombos,monoidsize,submonoidsize);
invalidBases = invalidBases - 1;
invalidBases = invalidBases(find(invalidBases < (monoidsize ^ monoidsize - submonoidsize)));
cycles = cycles - 1;
cycles = cycles(find(cycles < (monoidsize ^ monoidsize - submonoidsize)));


indicesArray = zeros(1,submonoidsize - 1);
indicesArray = find(indicesArray == 0) - 1;
currentMonoid = zeros(submonoidsize,monoidsize);

validMonoids = 0;
while(1)
    currentMonoid(2:end,1:end) = validCombos(indicesArray + 1,1:end);
    currentMonoid(1,1:end) = identity;
    if(validMonoid(currentMonoid))
        validMonoids = validMonoids + 1;
        disp([num2str(validMonoids), ': ', num2str(indicesArray)]);
    end
        
    if(~all((indicesArray ~= maxbound) == 0))
        indicesArray = cycleArrayBaseZeroBased(indicesArray,monoidsize^monoidsize-1,invalidBases);
        continue;
    else
        break;
    end
end

disp(' ');
disp([num2str(submonoidsize), ': ', num2str(validMonoids)]);