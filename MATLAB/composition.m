function [finalRow] = composition(row1,row2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
tempRow = zeros(1,size(row1,2));
for(k = 1:1:size(row1,2))
    tempRow(1,k) = row2(1,row1(1,k)+1);
end
finalRow = tempRow;

end

