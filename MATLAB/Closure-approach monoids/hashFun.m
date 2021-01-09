function [hash] = hashFun(cell)
%HASHFUN Summary of this function goes here
%   Detailed explanation goes here
hash = cell(end) + cell(ceil(end/2));

end