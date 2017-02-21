function partDiffx = partDiffx(f,Points,h)

%create our symbolic variables
syms x y z

%Converts string f to symbolic function g(x,y,z)
g(x,y,z) = eval(f);

%we define some auxiliar variables for the fivepoint formula
hx = Points(1)+h;
xh = Points(1)-h;
Doshx = Points(1)+2*h;
Dosxh = Points(1)-2*h;
ypoint = Poitns(2);
zpoint = Poitns(3);
    
%now we implement fivepoint formula for derivative of x
partDiffx = (g(Dosxh,ypoint,zpoint)-8*g(xh,ypoint,zpoint)+8*g(hx,ypoint,zpoint)-g(Doshx,ypoint,zpoint))/(12*h);

end
