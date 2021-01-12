function [result] = compose(a,b,table)
%COMPOSE Summary of this function goes here
%   Detailed explanation goes here
if(a == 0)
    result = b;
elseif(b == 0)
    result = a;
else
    result = table(a,b);
end

end

