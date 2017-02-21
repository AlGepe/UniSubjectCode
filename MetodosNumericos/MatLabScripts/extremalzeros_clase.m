function z1=extremalzeros(f,a,b)
%Intenta encontrar el cero mas pequeño y mas grande de f entre a y b

%Encontramos un cero que sea el candidato al mas pequeño:

z1=b;
h=.0001;
for n=1:(b-a)/h
    z=newtononevariable(f,a+n*h,1e-6);
    if (z<z1) && (a<z1) && (z<b)
        z1=z
    end
end
if z1==b
    error('no se han encontrado ceros en el intervalo')
end
