function y=piecewiselinearinterp(t,a,x)

%supongo que t est? ordenado
%genero vector y del tama?o de x
y=zeros(size(x));
for i=1:length(x)
    for j=1:length(t)-1
        if (x(i)>=t(j)) && (x(i)<=t(j+1))
            alpha=(x(i)-t(j+1))/(t(j)-t(j+1));
            y(i)= alpha*a(j)+(1-alpha)*a(j+1); %la componente i-esima
        end
    end
end

end