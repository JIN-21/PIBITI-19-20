#Rede robusta, esperado erro = 0

#Equa��es originais
A = [1 0 0 0 ;
     0 1 0 0 ;
     -1 1 0 0;
     -1 0 1 0;
     0 -1 1 0;
     0 -1 0 1;
     0 0 -1 1;
     0 0 -1 0;
     0 0 0 -1]
     
#observa��es     
L = [3.541 1.877 -1.664 -2.394 -0.730 -4.021 -3.291 -3.147 0.144]';

#observa��es acrescidas das esta��es conhecidas
L = L + [10 10 0 0 0 0 0 -8 -8]'

X = inv(A'*A)*A'*L

V = A*X - L
