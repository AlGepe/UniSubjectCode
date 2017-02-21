function Simp2D = SimpsonSimp2D(f,x,y)
%f is a 2D function_handle
%x is the interval in the first variable. Must be constat of function of y
%y is the interval in the second variable
xmed = sum(x) /2;
g = @(w) ((x(2)-x(1))/6)*(f([x(1),w])+4*f([xmed,w])+f([x(2),w]));
Simp2D = SimpsonSimp(g,y);
end