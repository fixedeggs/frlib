function [M,cliques] = BinaryPsdCompletion(M)

[r,~] = find(M);
r = unique(r);
[~,~,cliques] = conncomp(M(r,r));

for i=1:length(cliques)
    cliques{i} = r(cliques{i});
    M(cliques{i},cliques{i}) = 1;
end

