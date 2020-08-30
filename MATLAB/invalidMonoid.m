function [logicalValue] = invalidMonoid(monoid)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    temp = 0;
    for(i = 1:1:size(monoid,1))
        for(j = i+1:1:size(monoid,1))
            temp = temp + all(monoid(i,1:end) == monoid(j,1:end));
        end
    end
    logicalValue = temp;
end

