syms x

PoliWilki2(x) = (x-1)*(x-2)*(x-3)*(x-4)*(x-5)*(x-6)*(x-7)*(x-8)*(x-9)*(x-9.999999999)*...
    (x-11.00001)*(x-12)*(x-13)*(x-14)*(x-15)*(x-16)*(x-17)*(x-18)*(x-19)*(x-20);

x = linspace(-5,21,1000);

plot(x,PoliWilki(x))

hold on

plot(x,PoliWilki2(x),'r')