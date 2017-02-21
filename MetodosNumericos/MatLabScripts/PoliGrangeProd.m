function Yp = PoliGrangeProd(Xdata, Ydata, Xp)

n = max(size((Xp)));
Yp = zeros(1,n);
lambda = ones(size(Ydata));


for k=1:n %recorro para meter resultados en el polinomio 
    for j=1:length(Xdata)%recorro los puntos
        for i=1:length(Xdata)
            if j ~= i
            lambda(j) = lambda(j) * (Xp(k)-Xdata(i))/(Xdata(j)-Xdata(i));
            end
        end
    end
Yp(k) = sum(lambda.*Ydata);
end
end