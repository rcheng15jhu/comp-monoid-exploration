function [check] = testConsistency(table,print)
%TESTCONSISTENCY Summary of this function goes here
%   Detailed explanation goes here

numElements = size(table,1);
check = 1;
for a = 1:1:numElements
    for b = 1:1:numElements
        for c = 1:1:numElements
            if compose(compose(a,b,table),c,table) ~= compose(a,compose(b,c,table),table)
                check = 0;
                break;
            end
        end
        if(check == 0)
            break
        end
    end
    if(check == 0)
        break
    end
end

if print == 1 && check == 0
    disp(['a = ', num2str(a), ', b = ', num2str(b), ', c = ', num2str(c)]);
end

end

