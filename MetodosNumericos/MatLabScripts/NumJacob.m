%% NO FUNCIONA BIEN
%  This program uses inputs:
%  *f*: Vector function in the form of a function_handle with *n* variables
%       and *m* -dimension output.
%
%  *x* : Vector of dimension *n* cointaining the values of the variables where
%       we want to compute the Jacobian Matrix.
%
%  *h* : Our precision term, basically the length of our steps in computing
%   the derivative.
%  *NumbJacobian*  will return the Jacobian matrix of *f* in the points *x*
function NumJac = NumJacob(f,x,h)
%%  Define auxiliar variables
%  We set *n* & *m* relative to the size of *f* & *x* . They will be the dimensions
%  of the Jacobian matrix *NumJac* which we now initialice for improved
%  performance
tic;
n = length(x);
m = length(f(x));
NumJac = zeros(m,n);
%%  Matrix computation
%  Our strategy will be to compute all the derivates of all f components 
%  *f(i)* with respect to a certain variable *x(j)* before moving to the 
%  next variable *x(j+1)*.
%%  j-indexes computation
%  As our j indexes reffer to the variables x(j) found in f. We first set
%  some auxiliar vector to be the values of the terms in the fivePoints
%  formula that we'll use for computing NumJac
for j=1:n
    hj = zeros(1,n);
    hj(j) = h;
    a = f((x)-(2*hj));
    b = f(x-hj);
    c = f(x+hj);
    d = f(x+2*hj);
%% i-indexes computation
%  Now we compute all the elements of the *j* column by applying the
%  fivePoints formula to each of the components of *f* (remember we created 
%  auxiliar vectors for simplicity)
for i=1:m
        NumJac(i,j) = (a(i)-8*b(i)+8*c(i)-d(i))/(12*h);
%  Jump to i+1 and repeat
end
end
%  Jump to j+1 and repeat again
t1 = toc
end

%  Program returns NumJac
