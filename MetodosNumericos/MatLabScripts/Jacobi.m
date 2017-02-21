%Jacobi

%Nos dan los datos del sistema: A, B
n = input('Please introduce the number of dimensions of the system: ');
[A,B] = Matrix_ob1(n);
converge = 'It Converges';
%Creamos X a partir de B antes de iterar
X_k = ones (n,1 ); 
X_k1 = ones (n,1);
count = 0;
error = realmax;
i = 1;
error_i = 0;%--#Checked--%

%Siguiendo el metodo propuesto calculamos cada componenete de X_0 using M
while error_i < n
    error_i = 0;
    X_k = X_k1;
%For that we implement the sums formula for each element X_k+1 (i)
    while i <= n
        sum_i = 0;
        sum_n = 0;
        j = 1;
        %    X(i) = --SUMS THING--
        %sum until i-1
        while j < i
            sum_i = A(i,j)*X_k(j);
            j = j+1;
        end
        j = i+1;
        %calculus for the Sum until n
        while j <= n
            sum_n = A(i,j)*X_k(j);
            j = j+1;
        end
        %now we use the previously calculate sums to compute X(i)
        X_k1(i) = (-sum_i-sum_n+B(i))/A(i,i);
        i = i + 1;
    end
    %We meassure the error comparing A*X_k+1 with B
    error = (A*X_k1)- B;
    i = 1;
    while i <= n;
        if abs( error (i) ) < 1E-10;
            error_i = error_i + 1;
        end
        i = i+1;
    end %So if the error is small enough we break the loop 
    %This condition is the main condition for the outter while loop
    
    %We also keep a counting variable s.t. we are able to know the
    %iterations required for the agorithm
    count = count + 1;
    if count >= 100000
       converge = 'Does not converge';
       break
    end
end
display (X_k1);% we plot results (both X_k+1, number of iterations and error)
display ( abs(error) );
display (count);
display ( converge );