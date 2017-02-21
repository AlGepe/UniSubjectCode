function N = mifactorial(n)
if n == 0
    N = 1;
else
    N = n+mifactorial(n-1);
end