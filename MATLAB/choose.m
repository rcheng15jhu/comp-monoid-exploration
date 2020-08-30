function [choices] = choose(a,b)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
    tempChoices = zeros(1,a);
    tempChoices = find(tempChoices == 0);
    tempChoices = tempChoices - 1;
    choices = nchoosek(tempChoices,b);
end

