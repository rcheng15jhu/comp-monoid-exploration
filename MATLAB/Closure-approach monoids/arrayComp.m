function [comp] = arrayComp(a,b)
%ARRAYCOMP Compare two arrays of equal size
%   Return -1 if a < b, 1 if a > b, and 0 if a = b.
comp = 0;
for k = 1:1:size(a,2)
    if(a(k) < b(k))
        comp = -1;
        break;
    elseif(a(k) > b(k))
        comp = 1;
        break;
    end
end