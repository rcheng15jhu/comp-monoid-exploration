function [index] = identity(numElements)
%IDENTITY Summary of this function goes here
%   Detailed explanation goes here
index = (numElements^numElements - numElements)/(numElements-1)^2;
end

