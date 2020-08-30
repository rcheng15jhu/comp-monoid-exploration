function [finaltruth] = validMonoid(monoid)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%Get the array consisting of every row of the monoid composed with themselves.
finaltruth = 1;
msize = size(monoid,1);
for i = 1:1:msize
    for j = 1:1:msize
        comp = composition(monoid(i,1:end),monoid(j,1:end));
        temp = 0;
        for k = 1:1:msize
            if(all(comp == monoid(k,1:end)))
                temp = 1;
                break;
            end
        end
        
        %If composition is not in monoid...
        if(~temp)
            %disp([monoid(i,1:end), monoid(j,1:end)])
            finaltruth = 0;
            return;
        end
    end
end

end

