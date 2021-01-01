function [finaltruth] = validMonoid(monoid,table)
%Get the array consisting of every row of the monoid composed with themselves.
finaltruth = 1;
msize = size(monoid,1);
for i = msize:-1:2
    for j = msize:-1:2
        %Compose the two together
        comp = compositionZeroBased(monoid(i,1:end),monoid(j,1:end));
        
        %If composition is not in monoid...
        if(~ismember(comp,monoid,'rows'))
            finaltruth = 0;
            return;
        end
    end
end

end

