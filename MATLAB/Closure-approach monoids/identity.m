function [index] = identity(numElements)
%IDENTITY Returns the identity index of the transformation monoid of n elements
%   Identity index of n-element transformation monoid is (n^n - n)/(n - 1)^2
index = (numElements^numElements - numElements)/(numElements-1)^2;
end

