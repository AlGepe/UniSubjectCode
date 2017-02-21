n = input('Introduce las dimensiones de los vectores prueba');
T = rand(n,1);
A = rand(n,1);
% T = T.*1000;
% A = A.*10;
p = PoliGrangeN(T,A);
 %ezte eh er polinomio, pisha
 
vectort = linspace(min(min(T)),max(max(T)));
p2 = PoliGrangeProd(T,A,vectort);

%pp = @(t) p(1) + p(2)*t + p(3)*t.^2 + p(4)*t.^3;
 %Desde -10 a 10 con 100puntos.
plot (vectort, evaluapol(p,vectort),'o');
hold on
plot(T,A, 'x'); %Pinta un punto y 'x' como marca del punto
hold on
plot(vectort, p2);
hold off
