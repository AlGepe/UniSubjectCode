function dx=deriveFiveP(f,x,h)
%input will be a function_handle (f) and the point x where we want to compute the
%derivative (dx), will use the definition of derivarivate at a point
dx = zeros(size(x));
for i=1:length(x);
    f1=f(x(i)+2*h);
    f2=f(x(i)-h);
    f3=f(x(i)+h);
    f4=f(x(i)-2*h);
dx(i) = (f4-(8*f2)+(8*f3)-f1)/(12*h);
end