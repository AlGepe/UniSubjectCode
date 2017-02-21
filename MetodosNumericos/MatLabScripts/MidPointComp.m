function MidPComp = MidPointComp(f,x,n)
points = linspace(x(1),x(2),n);
MidPComp = 0;
for i=1:n-1
    MidPComp = MidPComp + MidPoinSimp(f,[points(n);points(n+1)]);
end
end