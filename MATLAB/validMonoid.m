function [finaltruth] = validMonoid(monoid)
%Get the array consisting of every row of the monoid composed with themselves.
finaltruth = 1;
msize = size(monoid,1);
for i = msize:-1:2
    for j = msize:-1:2
        %Compose the two together
        comp = composition(monoid(i,1:end),monoid(j,1:end));
        temp = 0;
        if(~all(comp == monoid(1,1:end)))
            for k = 2:1:msize
                if(all(comp == monoid(k,1:end)))
                    temp = 1;
                    break;
                end
                
                if(arrayLess(comp,monoid(k,1:end)))
                    break;
                end
            end
        else
            temp = 1;
        end
        
        %If composition is not in monoid...
        if(~temp)
            finaltruth = 0;
            return;
        end
    end
end

end

