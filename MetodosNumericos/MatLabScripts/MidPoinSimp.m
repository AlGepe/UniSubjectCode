function MidP = MidPoinSimp(f,x)
mid = (sum(x))/2;
MidP = (x(2)-x(1))*f(mid);
end