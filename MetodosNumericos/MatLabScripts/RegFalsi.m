function [zero,equis] = RegFalsi(f,a,b,epsilon)
zero = NaN;
equis = NaN;
if f(a) == f(b)
    fprintf('Error encountered: cannot divide by zero');
else
c = (a*f(a)-b*f(b))/(f(b)-f(a));
count  = 0;
while abs(f(c)) > epsilon && abs(a-b) >= epsilon
    count = count + 1;
    if f(a) == f(b)
        fprintf('Error encountered: cannot divide by zero at iteration')
        count
        return
    elseif sign(f(a)) == sign (f(c))
        a = c;
    else
        b = c;
    end    
    c = (a*f(a)-b*f(b))/(f(b)-f(a));
end
    count
zero = f(c);
equis = c;
end

end
