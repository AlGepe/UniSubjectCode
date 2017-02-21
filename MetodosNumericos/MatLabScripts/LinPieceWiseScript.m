X = input('Please input now vector with values for x or t');
Y = input('Please input now vector with values for y of f(x) or f(t)...');
Xp = input ('Please input now a vector with the point where the value of the function should be interpolated');
%If could break that long statement into too lines, I would

Xgen = linspace(0,max(X)-0.001,50);
Ypoint = linearpiecew(X,Y,Xp);
Ygen = linearpiecew(X,Y,Xgen);

plot (X , Y , 'ok');
hold on
plot (Xp,linearpiecew(X,Y,Xp), 'x');
hold on
plot (Xgen, linearpiecew(X,Y,Xgen));
hold off