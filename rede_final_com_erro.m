#Rede com erro aleat�rio

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

#componente do erro aleat�rio
#rnd foi gerada aleatoriamente, colocou-se aqui um vetor espec�fico para a reprodutibilidade dos testes
rnd = [-0.027   0.013   0.057   0.053  -0.175  -0.102  -0.080  -0.040  -0.057]';
L = L + rnd;

#observa��es acrescidas das esta��es conhecidas
L = L + [10 10 0 0 0 0 0 -8 -8]'

X = inv(A'*A)*A'*L

V = A*X - L
