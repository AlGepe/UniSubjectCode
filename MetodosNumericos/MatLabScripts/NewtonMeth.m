function [zero,equis] = NewtonMeth(f,x0,epsilon)

fx0 = f(x0);

while abs(fx0) > epsilon 
    x0 = x0 - (fx0)/(deriveFiveP(f,x0,epsilon));
    fx0 = f(x0);
end
zero = fx0;
equis = x0;
end