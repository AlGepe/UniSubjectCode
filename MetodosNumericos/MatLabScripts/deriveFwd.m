function dx=deriveFwd(f,x,h)
%input will be a functionhandler (f) and the point x where we want to compute the
%derivative (dx), will use the definition of derivarivate at a point
dx = zeros(size(x));
for i=1:length(x);
dx(i) = (f(x(i)+h)-f(x(i)))/h;
end