function [puntos,valores] = Euler(f, ya, a, b, h)

n = ceil((b-a)/h);
puntos = zeros(1,n+1);
valores = puntos;
puntos(1)=a;
valores(1)=ya;
for i=1:n
    puntos(i+1) = a+i*h;
    valores(i+1) = valores(i) + f(puntos(i),valores(i))*h;
end

end