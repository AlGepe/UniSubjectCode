fcadena = 'x^2';
aux = sprintf('fhandle=@(x) %s', fcadena);
eval(aux)
syms x 
fcademaderivada = char(diff(fcadena,x));
clear x
aux = sprintf('fhandelderivada=@(x) %s',fcadenaderivada);
eval(aux)