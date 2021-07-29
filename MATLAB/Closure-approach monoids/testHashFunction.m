clc;

numElements = 3;
max = numElements^numElements;
hashMax = 256;
hashes = zeros(1,hashMax);

for i = 1:1:size(monTable,1)
    for j = 1:1:size(monTable,2)
        for k = 1:1:size(monTable{i,j},2)
            for m = 1:1:size(monTable{i,j}{k},2)
                hash = hashFun(monTable{i,j}{k}{m},hashMax);
                hashes(hash) = hashes(hash) + 1;
            end
        end
    end
end

for i = 1:1:size(hashes,2)
    disp([num2str(i),': ',num2str(hashes(i))]);
end

clearvars max hashMax i j k;