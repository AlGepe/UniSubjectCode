function Itot = AdaptaSimpsonIteraND(f,a,b,epsilon)

% NOT FINISHED!!!!
%f is a function_handle of N variables
%a and b are vectors of size Nx1 containing respectively the smallest (a),
%and the biggest(b) values of the intervals in each direction.

%Initializaing of variables
Itot = 0; %The value of the integral
auxA = a; %auxiliar 'a' limit for the changing interval of intergration
auxB = b; %auxiliar 'b' limit for the changing interval of intergration

%% WIP
%auxA will run from a to b setting new auxiliar intervals (thus the name)
%when it reaches the value of b we have to stop or else will compute the
%integral out of the interval given.
while auxA ~= b
    auxMid = (auxA+auxB)/2; %midpoint of auxiliar interval
    Ione = SimpsonSimpND(f, [auxA;auxB]); %1st approx of integral
    Itwo = SimpsonSimpND(f,[auxA;auxMid])+SimpsonSimpND(f,[auxMid;auxB]);
    %2nd approx
    auxLen = auxB-auxA; %length of interval(used later)
    
if abs(Ione-Itwo)<= epsilon
    %if condition is met we store the result adding it to the partial
    %result, untill we end the outter while loop.
    Itot = Itot + Itwo;
    
    %we now set new intervals for simpson iteration.
    if rem((auxB-a)/auxLen,2) == 0        
        %if the length of our interval is contained an even number of times
        %that can only mean we've completed that 'depth' and shall now go
        %to the 'upper' level
        auxA = auxB;
        auxB = auxB+2*auxLen;
        
    else
        %on the contrary, if our auxLen is contained an odd number of times
        %we shall continue in the same depth as to complete the twin
        %intervals
        auxA = auxB;
        auxB = auxB+auxLen;
        
    end %end of innner if (decides how to set the new interval)
    
else
    %if condition is not met we keep on 'digging deeper' to a new interval
    %with half the length of the current
    auxB = auxMid;
    
end %end of outer if (checks whether to compute integral or divide interval)
%and now we repeat the same process for the new intervals
end %end of while loop -process completed-

end