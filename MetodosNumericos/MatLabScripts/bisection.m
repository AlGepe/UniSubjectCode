function [zero,equis] = bisection(f,a,b, epsilon)
fa = f(a);
fb = f(b);
if fb*fa >0
    disp('Mas dao dos puntos con er mismo sicno, fierah')
    disp('O mi los das vien la prosima ves u te rebiento, tontolculo')
    zero = NaN;
    equis = NaN;
elseif abs(fb) < epsilon
    disp('as tenio to la suerte, f(b) es (casi) cero')
elseif abs(fa) < epsilon
    disp('as tenio to la suerte, f(a) es (casi) cero')
else
    
    
    
%count = 0;
c = (a+b)/2;
fc = f(c);
while abs(fc) > epsilon
    %count = count+1;
    if fc*fa > 0
        a = c;
    else 
        b = c;
    end
    c = (a+b)/2;
    fc = f(c);
end
%count;
zero = f(c);
equis = c;
end