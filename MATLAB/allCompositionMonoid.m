clear;
clc;

%The only thing you can change.
monoidsize = 8;
%Global submonoid size.
submonoidsize = 2;
validCombos = allValidCombos(monoidsize);
identityNum = (monoidsize^monoidsize - monoidsize)/(monoidsize - 1)^2;
identity = validCombos(identityNum,1:end);
%Excise identity element.
validCombos = validCombos([1:identityNum-1,identityNum+1:end],1:end);

%for i = submonoidsize:1:monoidsize^monoidsize
for i = submonoidsize:1:submonoidsize
    
indicesArray = zeros(1,submonoidsize - 1);
indicesArray = find(indicesArray == 0) - 1;

currentMonoid = zeros(submonoidsize,monoidsize);
validMonoids = 0;
%Instead of -1, improve bound.
maxbound = (size(validCombos,1)-1) * ones(1,size(indicesArray,2));

while(1)
    increaseCheck = 0;
    for j = 2:1:size(indicesArray,2)
        increaseCheck = increaseCheck + (indicesArray(j) <= indicesArray(j - 1));
    end
    strictlyIncreasing = ~increaseCheck;
    
    if(strictlyIncreasing)
        currentMonoid(2:end,1:end) = validCombos(indicesArray + 1,1:end);
        currentMonoid(1,1:end) = identity;
        if(~invalidMonoid(currentMonoid))
            if(validMonoid(currentMonoid))
                validMonoids = validMonoids + 1;
                %disp([num2str(validMonoids), ': ', num2str(indicesArray+1)]);
                disp(num2str(validMonoids));
                %disp(identity);
                %for i = 1:1:submonoidsize-1
                    %disp(validCombos(indicesArray(i)+1,1:end));
                %end
                
            end
        end
    end
    if(~all((indicesArray ~= maxbound) == 0))
        indicesArray = cycleArrayBase(indicesArray,size(validCombos,1),1);
        continue;
    else
        break;
    end
end

disp(' ');
disp([num2str(i), ': ', num2str(validMonoids)]);
submonoidsize = submonoidsize + 1;
end