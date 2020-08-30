function [finaltruth] = powerMonoid(monoid)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%Get the array consisting of every row of the monoid composed with themselves.
finaltruth = 1;

submonoid = monoid;
msize = size(submonoid,1);
checklist = zeros(1,msize);

activeElem = submonoid(1);
while(%Conditional)
    if(%activeElem is in monoid
        %Add activeElem to checklist
        %Remove activeElem from monoid
    elseif(%activeElem is not in checklist
        
    end
end

end

