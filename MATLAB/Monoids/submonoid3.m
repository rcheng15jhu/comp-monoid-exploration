clc;
clear;

n=11;

f1 = 0;
for k=1:1:floor(n/3)
    f1 = f1 + factorial(n)/(2*3^k*factorial(k)*factorial(n-3*k));
end

f2 = submonoid3family2(n);

f3 = 0;
for k=2:1:n-1
    f3 = f3 + nchoosek(n,k)*nchoosek(k^(n-k),2);
end

f4 = 0;
for j=2:1:n-1
    for k=1:1:floor(j/2)
        f4 = f4 + (factorial(n)*j^(n-j))/(factorial(n-j)*factorial(k)*2^(k)*factorial(j-2*k));
    end
end

f5a = 0;
for j=1:1:n-2
    for k=1:1:floor((n-j)/2)
        f5a = f5a + (factorial(n)*j^(n-j-k))/(factorial(j)*factorial(k)*2^(k)*factorial(n-j-2*k));
    end
end

f5b = 0;
for j=1:1:n-2
    for k=1:1:n-j-1
        f5b = f5b + nchoosek(n,j)*nchoosek(n-j,k)*j^(k)*k^(n-j-k);
    end
end

f5c = 0;
for j=2:1:n-1
    for k=1:1:j-1
        f5c = f5c + nchoosek(n,j)*nchoosek(j,k)*k^(j-k)*j^(n-j);
    end
end



disp(['f1 : ',num2str(f1)]);
disp(['f2 : ',num2str(f2)]);
disp(['f3 : ',num2str(f3)]);
disp(['f4 : ',num2str(f4)]);
disp(['f5a: ',num2str(f5a)]);
disp(['f5b: ',num2str(f5b)]);
disp(['f5c: ',num2str(f5c)]);
disp(['total: ',num2str(f1+f2+f3+f4+f5a+f5b+f5c)]);