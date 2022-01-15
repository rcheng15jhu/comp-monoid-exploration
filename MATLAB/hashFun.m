function [hash] = hashFun(cell, max)
%HASHFUN Summary of this function goes here
%   Detailed explanation goes here

hash = 1;
for i=1:1:size(cell,2)
    hash = bitxor(2*hash,cell(i)+i);
end
hash = 1 + mod(hash,max);

end