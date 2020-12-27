function [output] = landau(input)
%LANDAU Approximate Landau's function.
%   Doesn't actually come close to Landau's function, instead approximates
%   largest possible product of partition of input.
output = floor(exp(input/exp(1)));
end

