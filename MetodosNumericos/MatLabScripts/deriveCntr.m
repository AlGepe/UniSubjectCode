function dx=deriveCntr(f,x,h)
%input will be a function (f) and the point x where we want to compute the
%derivative (dx), will use the definition of derivarivate at a point
dx = zeros(size(x));
for i=1:length(x);
dx(i) = (f(x(i)+h)-f(x(i)-h))/(2*h);
end