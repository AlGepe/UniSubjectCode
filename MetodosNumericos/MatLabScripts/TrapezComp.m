function TrapzComp = TrapezComp(f,x,n)
points = linspace(x(1),x(2),n);
TrapzComp = 0;
for i=1:n-1
    TrapzComp = TrapzComp +TrapezSimp(f,[points(n);points(n+1)]);
end
end