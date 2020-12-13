function [finalRow] = composition(row1,row2)
%Base function that composes two mappings.
tempRow = zeros(1,size(row1,2));
for(k = 1:1:size(row1,2))
    tempRow(1,k) = row2(1,row1(1,k)+1);
end
finalRow = tempRow;

end

