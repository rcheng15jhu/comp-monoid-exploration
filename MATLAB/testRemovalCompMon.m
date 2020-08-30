clear;
clc;

%The only thing you can change.
monoidsize = 3;
%Global submonoid size.
validCombos = allValidCombos(monoidsize);
identityNum = 6;
identity = validCombos(6,1:end);
%Excise identity element.
validCombos = validCombos([1:5,7:end],1:end);

validMonoids = 0;

for c = 1:1:18
for d = c+1:1:19
for e = d+1:1:20
for f = e+1:1:21
for g = f+1:1:22
for h = g+1:1:23
for i = h+1:1:24
for j = i+1:1:25
for k = j+1:1:26
currentMonoid = zeros(18,3);
indices = zeros(1,26);
indices = find(indices == 0);
indices = indices(indices ~= c);
indices = indices(indices ~= d);
indices = indices(indices ~= e);
indices = indices(indices ~= f);
indices = indices(indices ~= g);
indices = indices(indices ~= h);
indices = indices(indices ~= i);
indices = indices(indices ~= j);
indices = indices(indices ~= k);

currentMonoid(2:end,1:end) = validCombos(indices,1:end);
currentMonoid(1,1:end) = identity;

if(validMonoid(currentMonoid))
    validMonoids = validMonoids + 1;
	disp([num2str(validMonoids),': ',num2str(indices-1)]);
end

end
end
end
end
end
end
end
end
end
disp(validMonoids);