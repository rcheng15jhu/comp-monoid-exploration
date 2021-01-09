clc;

numElements = 4;
max = numElements^numElements;
hashMax = 513;
hashes = zeros(1,hashMax);

for i = 1:1:size(monTable,1)
    for j = 1:1:size(monTable,2)
        for k = 1:1:size(monTable{i,j},2)
            hash = hashFun(monTable{i,j}{1,k});
            hashes(hash) = hashes(hash) + 1;
        end
    end
end

for i = 1:1:size(hashes,2)
    disp([num2str(i),': ',num2str(hashes(i))]);
end

clearvars max hashMax i j k;