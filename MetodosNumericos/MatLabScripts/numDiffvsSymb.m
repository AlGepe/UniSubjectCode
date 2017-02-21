%%  Description
%
%   Matlab script that plots in the same window numerical and symbolic
%   derivative of an input function *f*. It also asks for the interval that
%   should be plotted, the precision in terms of *h* and the numerical
%   *method*

%%  Comand Window - Inputs
%  Self-explained inputs set as comments
% 
%  Example inputs set for demonstration purposes
%   

f = 'x^cos(x)'; %input('Please input the function you want to derive as a string');
interv = [-5,5]; %input('Set the X-interval that should be plotted as a 2-value vector');
h = 0.01; %input('Input the precision (in terms of the value of "h")');
method = 'central'; %input('Choose the numerical method from "forward","central" or "fivepoints" [insert as a string]');

%%  Auxiliar variables
%  We calculate the width of our interval for accuracy purposes when
%  plotting and calculating using |linspace| function

width = abs(interv(1)-interv(2));

%  Set the values of x we shall plot with 100 values per unit of length of
%  *x*

Xpoints = linspace(min(interv),max(interv),100*width);

%%  Compute derivatives   
%  We call |numericalderivative| to compute the numerical derivative of *f*
%  

Ypoints = numericalderivative(f, Xpoints, method,h);   
%%
% We set *x* to be a symbolical variable and differenciate *f* with
%  respect to it

syms x
g(x) = diff(eval(f));

x = Xpoints; %auxiliar change on the value of x for easy reading

%%  Plotting results
%
%
plot(x,Ypoints,'ro',x,g(x),'b');
hold off

