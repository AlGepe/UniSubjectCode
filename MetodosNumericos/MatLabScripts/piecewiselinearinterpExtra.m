function y=piecewiselinearinterpExtra(t,a,x)

%supongo que t est? ordenado
%genero vector y del tama?o de x

if size(t,z)>size(t,1)
    t=t';
end
if size(a,2)>size(a,1)
    a=a';
end
A=sortrows([t a]); %ordeno t y coloco a
t=A(:,1);
a=A(:,2);
    

y=zeros(size(x));
for i=1:length(x)
    fin=0;
    j=1;
    while (fin==0) && j<max(size(x))
        if (x(i)>=t(j)) && (x(i)<=t(j+1))
            fin=1;
            alpha=(x(i)-t(j+1))/(t(j)-t(j+1));
            y(i)= alpha*a(j)+(1-alpha)*a(j+1); %la componente i-esima
        end
    end
    if fin == 0
        y(i) = NaN;
end

end