function AdaSimp2D = AdaptaSimpson2D(f,x,y,epsilon)
Ia = SimpsonSimp2D(f,x,y);

intervX1 = [x(1);sum(x)/2];%dividir el intervalo x en dos
intervX2 = [sum(x)/2;x(2)];
intervY1 = [y(1);sum(y)/2];%dividir el intervalo y en dos
intervY2 = [sum(y)/2;y(2)];

%calcular para cada uno de los 4 semi-rectangulos
Ib = SimpsonSimp2D(f,intervX1,intervY1)+...
     SimpsonSimp2D(f,intervX1,intervY2)+...
     SimpsonSimp2D(f,intervX2,intervY1)+...
     SimpsonSimp2D(f,intervX2,intervY2);
 
if abs(Ia-Ib) >= epsilon
    AdaSimp2D = AdaptaSimpson2D(f,intervX1,intervY1,epsilon)+...
                AdaptaSimpson2D(f,intervX1,intervY2,epsilon)+...
                AdaptaSimpson2D(f,intervX2,intervY1,epsilon)+...
                AdaptaSimpson2D(f,intervX2,intervY2,epsilon);%cada uno de los 4 intervalos)
else
    AdaSimp2D = Ib;
end

end