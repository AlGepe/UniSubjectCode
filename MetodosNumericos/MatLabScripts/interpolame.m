function y=interpolame(f,t)
%f=funcion a interpolar con @
ft = f(t);
p = PoliGrangeN(t, ft);

figure(1)
clf
hold on 
plot(t,ft,'ob');
hold on
tt=linspace(min(t),max(t),200);
plot(tt, f(tt), 'k'); %funcion original
hold on
pot(tt,evaluapol(p,tt),'r');
hold off
end 


%WTF!!!