function d2x=doubleDerivCntr(f,x,h)
%utilizando el m?todo anterior calculamos la segunda derivada
dfhx=deriveCntr(f,x-h,h);%calculamos f'(x-h)
dfxh=deriveCntr(f,x+h,h);%calculamos f'(x+h)
d2x=(dfxh-dfhx)/(2*h);
end