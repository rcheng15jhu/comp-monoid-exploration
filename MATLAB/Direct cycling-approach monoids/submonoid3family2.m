function [result] = submonoid3family2(partitionSize)
partitionArray = partitions(partitionSize);

result = 0;
for i = 1:1:size(partitionArray,1)
    prod = 1;
    for j = 1:1:size(partitionArray{i,1},2)
        prod = prod * size(partitionArray{i,1}{j},2);
    end
    prod = prod * (prod - 1);
    result = result + prod;
end
result  = result / 2;