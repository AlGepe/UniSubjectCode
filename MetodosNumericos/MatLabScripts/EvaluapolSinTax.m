function valores = EvaluapolSinTax (p,t)
%Dados los coeficientes del polinomio (vector p), siendo p(1) el t?rmino
%independiente y p(end) el t?rmino t^N. p tendr? N+1 t?rminos y grado N. Y
%dado el vector t (con K valores), devuelve el valor de p(t_i) para
%i=1,...,K
valores = zeros(size(t));
for i=1:max(size(t))
    valores(i) = p(1);%p(t_i) con bucle for, me temo
    for j=1:max(size(p))
        valores = valores + p(j)*(t(i))^(j-1);
    end
end

    
%Forma ?ptima -> polyval(flipud(p),0) ??