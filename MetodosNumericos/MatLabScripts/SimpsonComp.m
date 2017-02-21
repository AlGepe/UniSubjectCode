function SimpComp = SimpsonComp(f,x,n)
points = linspace(x(1),x(2),n/2);
SimpComp = 0;

for i=1:(n/2)-1
    SimpComp = SimpComp + SimpsonSimp(f,[points(i);points(i+1)]);
end
end