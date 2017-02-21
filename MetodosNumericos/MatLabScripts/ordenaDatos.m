function XY=ordenaDatos(X, Y)
XY = [sort(X); ones(1,max(size(X)))];%Ordenamos el vector X y almacenamos en XY(1:)
for i=1:max(size(X)) %aqu? recorremos el vector X sin ordenar y comparamos con el ordenado
    j = 1;
    while XY(1,i)~= X(j) %si no coinciden los valores pasamos al siguiente
        j =j+1;
    end
    XY(2,i) = Y(j);%ordenamos Y en la 2a columna de XY
    X(j) = 0;%ponemos Xj a cero para evitar duplicidades raras
end
end