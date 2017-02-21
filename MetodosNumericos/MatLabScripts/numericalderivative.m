function derf=numericalderivative (f, xdata, method,h)

%This function receives the function to derive as a string (f),
%the points where derivative shall be calculated as an array/vectorclc of numbers(xdata),
%the method we shall use to compute it as a string (method),
%and the value of h as a single number (h).

derf=zeros(1,length(xdata)); %Initialize the matrix containing the results

%We now set the conditions and compute using the corresponding matlab-function

if isequal(method,'forward') 
        derf = deriveFwd(@(x) eval(f),xdata,h);
elseif isequal(method,'central')
        derf = deriveCntr(@(x) eval(f),xdata,h);
elseif isequal(method,'fivepoints')
        derf = deriveFiveP(@(x) eval(f),xdata,h);
else
    display('Error al leer el metodo, compruebe que es un string de la forma "forward", "central" o "fivepoints"');
end
end