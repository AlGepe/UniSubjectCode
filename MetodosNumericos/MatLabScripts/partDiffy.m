function partDiffy = partDiffy(f,Points,h)

%create our symbolic variables
syms x y z

%Converts string f to symbolic function g(x,y,z)
g(x,y,z) = eval(f);

%we define some auxiliar variables for the fivepoint formula
hy = Points(2)+h;
yh = Points(2)-h;
Doshy = Points(2)+2*h;
Dosyh = Points(2)-2*h;
xpoint = Poitns(1);
zpoint = Poitns(3);
    
%now we implement fivepoint formula for derivative of x
partDiffy = (g(xpoint,Dosyh,zpoint)-8*g(xpoint,yh,zpoint)+8*g(xpoint,hy,zpoint)-g(xpoint,Doshy,zpoint))/(12*h);

end