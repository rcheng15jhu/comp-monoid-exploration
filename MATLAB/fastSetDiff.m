function [set1diff,set2diff,totalset,size1,size2] = fastSetDiff(set1,set2)
%FASTSETDIFF Takes two SORTED arrays and returns their set diffs with sizes
%   Takes a climbing ladder approach to finding set differences.

i = 1;
j = 1;
size1 = 0;
size2 = 0;

set1diff = [];
set2diff = [];
totalset = [];
while i <= size(set1,2) && j <= size(set2,2)
    if(set1(1,i) < set2(1,j))
        set1diff = [set1diff,set1(i)];
        totalset = [totalset,set1(i)];
        i = i+1;
    else
        if (set2(1,j) < set1(1,i))
            set2diff = [set2diff,set2(j)];
            totalset = [totalset,set2(j)];
            j = j+1;
        else
            totalset = [totalset, set1(i)];
            i = i+1;
            j = j+1;
        end
    end
end
set1diff = [set1diff,set1(i:end)];
size1 = size(set1diff,2);
set2diff = [set2diff,set2(j:end)];
size2 = size(set2diff,2);
totalset = [totalset,set1(i:end),set2(j:end)];

end

