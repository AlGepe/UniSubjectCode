function partDiffz = partDiffz(f,Points,h)

%create our symbolic variables
syms x y z

%Converts string f to symbolic function g(x,y,z)
g(x,y,z) = eval(f);

%we define some auxiliar variables for the fivepoint formula
hz = Points(3)+h;
zh = Points(3)-h;
Doshz = Points(3)+2*h;
Doszh = Points(3)-2*h;
ypoint = Poitns(2);
xpoint = Poitns(1);
    
%now we implement fivepoint formula for derivative of x
partDiffz = (g(point,ypoint,Doszh)-8*g(xpoint,ypoint,zh)+8*g(xpoint,ypoint,hz)-g(xpoint,ypoint,Doshz))/(12*h);

end