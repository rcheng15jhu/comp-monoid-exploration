function [hash] = hashFun(cell)
%HASHFUN Summary of this function goes here
%   Detailed explanation goes here
k = cell(end) + cell(ceil(end/2)) + cell(1);
hash = 1+mod(k,256)+mod(k,128);

end