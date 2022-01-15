function [less] = arrayLess(a,b)
%ARRAYLESS Check if one array is lexicographically less than the other
%   Detailed explanation goes here
less = false;
for k = 1:1:size(a,2)
    if(a(k) < b(k))
        less = true;
        break;
    elseif(a(k) > b(k))
        break;
    end
end

