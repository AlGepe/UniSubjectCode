function y = test(f, x)

xpoint = x;
h = 0.001;

syms x ;

k(x) = eval(f); 
g(x) = k(k(x));

y = (g(xpoint-2*h)-8*g(xpoint-h)+8*g(xpoint+h)-g(xpoint+2*h))/(12*h);

end