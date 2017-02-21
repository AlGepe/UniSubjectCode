function x = closest(a,b)

epsilon = 1E-6; %error

f = @(x) 4*x^3+2*x*(1-2*b)-2*a; %derivative of a distance-like function to minimize

runner = sign(a)*0.2;

if a == 0
    fprintf('"a" se encuentra sobre el eje de oordenadas por lo que la soluci?n es doble, vale tanto +x como -x')
end

if a > 0
    
    init = sign(f(0.1));
    tracker = init;
    
    while tracker*init > 0
        
        tracker = f(runner+0.1);
        runner = runner+0.1;       
    end
    
    [y,x] = bisection(f,runner,runner-0.1,epsilon);
else
    
    init = sign(f(-0.1));
    tracker = f(runner);
    
    while tracker*init > 0
        
        tracker = f(runner-0.1); 
        runner = runner-0.1;
       
    end
    
    [y,x] = bisection(f,runner,runner+0.1,epsilon);
    
end

% [y,x] = bisection(f,,f(runner),epsilon); %apply newton methof to f to find zeros, 
                              %that is to minimize de distance function

end