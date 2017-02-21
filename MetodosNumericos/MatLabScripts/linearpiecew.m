%LinearPiecewise
function Ypoint = linearpiecew(Xdata, Ydata, Xpoint)
XY = ordenaDatos(Xdata,Ydata); %XY will be the 2x2 matrix containing both 
%vectors ordered (increasing order) Xdata & Ydata each of them in a row
Xdata = XY(1,:);
Ydata = XY(2,:);
Ypoint = ones(size(Xpoint));

for i=1:max(size(Xpoint))
    j = 2;
    while Xpoint(i) >= Xdata(j) %for simplicity we assume the biggest... 
                         %Xpoint(i)is smaller than the biggest Xdata(j) 
        j = j+1;
    end
   
    Ypoint(i) = Ydata(j-1)+(Ydata(j)-Ydata(j-1))*(Xpoint(i)-Xdata(j-1))/(Xdata(j)-Xdata(j-1));
    Xpoint(i) = 0;
end
end