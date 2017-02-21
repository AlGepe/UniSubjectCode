function AdaSimp = AdaptaSimpsonCount(f,x,epsilon)
Ia = SimpsonSimp(f,x);
aux1 = [x(1);(x(1)+x(2))/2];%created for easy understanding of the code
aux2 = [(x(1)+x(2))/2;x(2)];%divides interval into 2 halves
fprintf('x');
Ib = SimpsonSimp(f,aux1) + SimpsonSimp(f,aux2);% 2nd approximation
if abs(Ia-Ib)>= epsilon
    AdaSimp = AdaptaSimpsonCount(f,aux1,epsilon) + AdaptaSimpsonCount(f,aux2,epsilon);
else
    AdaSimp = Ib;
end
