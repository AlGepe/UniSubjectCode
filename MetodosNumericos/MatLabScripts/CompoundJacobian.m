function ComJac = CompoundJacobian(f,g,x,h)
fpoint = zeros(lengthf(x(i)));
for i=1:
fpoint(i) = f(x(i));

Jg = NumJacob(g,fpoint,h);

Jf = NumJacob(f,x,h);

ComJac = Jg * Jf;
end