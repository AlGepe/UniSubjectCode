function Trap = TrapezSimp(f,x)
%f es la funci?n en function_handle
%x es el vector de puntos con dos valores
Trap  = (x(2)-x(1))*((f(x(1)+f(x(2))/2)));
end