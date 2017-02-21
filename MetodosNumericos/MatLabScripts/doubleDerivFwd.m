function d2x=doubleDerivFwd(f,x,h)
%utilizando el m?todo anterior calculamos la segunda derivada
dfx=deriveFwd(f,x,h);%calculamos f'(x)
dfxh=deriveFwd(f,x+h,h);%calculamos f'(x+h)
d2x=(dfxh-dfx)/h;
end