%%  Adaptative Simpson Method

function AdaSimp = AdaptaSimpson(f,x,epsilon)
tic;
%  AdaptaSimpson computes the integral of *f* in the interval *[x(1),x(2)]* 
%  by using the adaptative version of Simpson's Method iterating up to a 
%  difference of *epsilon* between iterations. 

%%  Compute to compare
% 
%  We compute the 1st approximation using simpson simple once (Ia)
%  We then compute the 2nd approximation by computing Simpson Simple on
%  each half of our interval
% 
Ia = SimpsonSimp(f,x);%1st approximation
mid = (x(1)+x(2))/2;
aux1 = [x(1); mid];%created for easy understanding of the code
aux2 = [mid ; x(2)];
Ib = SimpsonSimp(f,aux1) + SimpsonSimp(f,aux2);% 2nd approximation
%%  Condition and iterations
% 
%  We will test if our improvement is bigger that the given error, in which
%  case we'll apply AdaptaSimpson to each half of the interval to
%  improve out precission. 
%
%  If our improvement is smaller than the given  *epsilon*  we return the
%  best approximation (Ib)
% 
if abs(Ia-Ib)>= epsilon
    AdaSimp = AdaptaSimpson(f,aux1,epsilon) + AdaptaSimpson(f,aux2,epsilon);
else
    
%  We set our variable to the most accurate result before the improvement
%  is smaller than the given value, *epsilon*.
    AdaSimp = Ib;
%%  Result
% 
%  The result returned by the function, *AdaSimp* , will be the 2nd
%  approximation if our improvement is smaller than  *epsilon*  or the sum
%  of applying AdaptaSimpson to both halfs of our initial interval. That
%  sum is a sum of integral approximation with improvement less than
%  *epsilon*  as required by the  *if*  condition in AdaptaSimpson.
%  TEXT
% 
toc;
end
