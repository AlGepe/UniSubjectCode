%%  DESCRIPTION
%  Function receives the following input:
%
%  *f* : Array of functions of 1 to 3 variables in the form of a string
%        Variables used must be x, x and y, or x, y and z depending on the
%        number of variables functions have.
%
%  *varPoints* : Array containing the point we derive at.
%                 Should contain as many values as variables have *f*
%
%  *h* : This sets our algorithm precision.
%
%  With this inputs we compute the Jacobian Matrix for all functions f(i)
%  at the points x = varPoints(1), y = varPoints(2)... and so on.
%
%  The method we'll be using for computing derivatives would be the
%  FivePoint formula modified for 1-3 variables as follows:
%
% 
% 
% $$\frac  {\partial f(x,y,z)}{\partial x} =
% \frac{f(x-2h,y,z)-8f(x-h,y,z)+8f(x+h,y,z)-f(x+2h,y,z)}{12h}$$
% 
% 
%%  Function
% 
%
%  Define function and initialize our output
function NumJac = NumericalJacobian(f,varPoints,h)

NumJac = zeros(lenght(f),lenght(varPoints));
%%
%  Set 'if' conditions for the #variables == length(varPoints)
if length(varPoints) == 1
%%
%  Compute derivates for 1-variable functions
    for i=1:length(f)
        NumJac(i,1) = partDiffx(f(i),varPoints,h);
    end
elseif length(varPoints) == 2
%%
%  Compute derivates for 2-variable functions
    for i=1:length(f)
        NumJac(i,1) = partDiffx(f(i),varPoints,h);
        NumJac(i,2) = partDiffy(f(i),varPoints,h);
    end
elseif length(varPoints) == 3
%%    
%  Compute derivates for 3-variable functions
    for i=1:length(f)
        NumJac(i,1) = partDiffx(f(i),varPoints,h);
        NumJac(i,2) = partDiffy(f(i),varPoints,h);
        NumJac(i,3) = partDiffz(f(i),varPoints,h);
    end
else
%%    
%  As this function only works for up to 3variables, we set an error text
%  to be displayed if input function have #variables>3... or #variables<1
%  (accounting for stupidness/absentmindness)
        display('This program does not support more than 3 variable, sorry')
end
end
%%  END
%  Function ends here returning the numerical approximation of the
%  Jacobian Matrix, saved in NumJac