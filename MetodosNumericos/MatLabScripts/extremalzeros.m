function [zmin,zmax] = extremalzeros(f,a,b)
% Find the places f(x)=0 which are closests to a y b
e=0.0001;
h=0.001;
%Initialisierung
zmin = b;
zmax = a;

for i=1:(b-a)/h
    zneu = newtononevariable(a+h*i, f, e);
    if( zneu<b && zneu>a )   % liegt in [a,b]
        if( zneu<zmin )
            zmin=zneu;
        elseif( zneu > zmax )
            zmax=zneu;
        end
    end
end

if(zmin==b || zmax==a)
    zmin = nan; %error('Nicht erfolgreich');
    zmax = nan;
end

% fun =@(x) log(x.^2+1)-exp(0.4*x).*cos(pi*x);
% ex = extremalzeros( fun,5,15 );
% x = linspace(-4,15);
% plot(x,fun(x),x,zeros(1,numel(x)),ex,[0,0],'or')
% xlim([-4,15]);
