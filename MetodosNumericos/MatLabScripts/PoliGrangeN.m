function p = PoliGrangeN(X,F)

if size(X,2)>size(X,1)
     X = X';
end

N = max(size(F));
M = ones(N);

for i=1:N
    for j=2:N
        M(i,j) = X(i)^(j-1);
    end
end

p = M\F;

end