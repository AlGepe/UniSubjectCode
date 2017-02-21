%UsaSimpson
f = input('introduce una funcion');
k = 1500;
xx = 1:k;
yy = xx;

for i=1:k
    yy(i) = SimpsonComp(f,[0;10], xx(i));
end
%subplot(1,2,1) %grafico con subgraficos(1fila, 2 column)
%y escojo el primero
%subplot(1,2,2) %escojo el segundo
plot(xx,yy,xx,ones(size(xx))*AdaptaSimpsonIterativo(f,[0;10],0.0001));