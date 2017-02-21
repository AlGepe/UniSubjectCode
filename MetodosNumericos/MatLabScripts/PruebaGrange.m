poliTheor = PoliGrangeProd(t,a);
num = max(size(poliTheor));
poliTherplot = @(x) 1;
for i=1:num
    poliTherplot = @(x) poliTherplot(x)+poliTheor(i)*x.^(num-i);
end
poliEx = @(x) 0*x.^4+(-1/48)*x.^3+(15/16)*x.^2+(-47/48)*x+(33/16);
xpoint = linspace(-4,4,10000);
plot(xpoint,poliTherplot(xpoint))
hold on
plot(xpoint,poliEx(xpoint),'r')
hold on
plot(t,a,'x')