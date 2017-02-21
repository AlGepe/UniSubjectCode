function Simp = SimpsonSimp(f,x)

mid = (sum(x))/2;

Simp = ((x(2)-x(1))/6)*(f(x(1))+4*f(mid)+f(x(2)));

end