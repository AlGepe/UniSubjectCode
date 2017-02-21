function derStr=analDeriv(f)
if isequal(f,'x.^2')
    derStr = '2*x';
elseif isequal(f,'x.^2-x')
    derStr = '2*x-1';
elseif isequal(f,'sin(x)')
    derStr = 'cos(x)' ;
elseif isequal(f,'cos(x)')
    derStr = '-sin(x)';
elseif isequal(f,'exp(cos(x))')
    derStr = 'exp(cos(x) * cos(x) * (-sin(x))';
elseif isequal(f,'abs(x)')
    derStr = '1' ;
elseif isequal(f,'x/(1+x.^2)')
    derStr = '(1+x.^2 - 3*x)/(1+x.^2)';
elseif isequal(f,'log(2+x)')
    derStr = '1/(2+x)';
end
end


%syms