function [isomorphs] = iso(combo)
    numElements = size(combo,1);
    permutations = perms(1:numElements);
    isomorphs = cell(1,0);
    curIso = combo;
    for p = 1:1:size(permutations,1)
        for i = 1:1:size(combo,1)
            for j = 1:1:size(combo,2)
                if combo(i,j) ~= 0
                    curIso(permutations(p,i),permutations(p,j)) = permutations(p,combo(i,j));
                else
                    curIso(permutations(p,i),permutations(p,j)) = 0;
                end
            end
        end
        isomorphs{1,end+1} = curIso;
    end
end