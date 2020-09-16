#Rede 2 com sigma = 1/dist nas observações

pkg load statistics

#Equações originais
A = [1 0 0 0 ;
     0 1 0 0 ;
     -1 1 0 0 ;
     -1 0 1 0 ;
     0 -1 1 0 ;
     0 -1 0 1 ;
     0 0 -1 1 ;
     0 0 -1 0 ;
     0 0 0 -1 ];

#observações     
L = [3.541 1.877 -1.664 -2.394 -0.730 -4.021 -3.291 -3.147 0.144]';

#adicionar o componente aleatório
#rnd foi gerada aleatoriamente, colocou-se aqui um vetor específico para a reprodutibilidade dos testes
rnd = [-0.027   0.013   0.057   0.053  -0.175  -0.102  -0.080  -0.040  -0.057]';
L = L + rnd;

for j = 1:(length(L))
   L(j) = L(j) + normrnd(0, 7e-5, 1);
endfor

#escolhe uma equação para introduzir o erro
i = round(9*rand(1));
#introduz o erro na equação escolhida
Le = L;
Le(i) *= -1; 
Le;

#observações acrescidas das estações conhecidas
Le = Le + [10 10 0 0 0 0 0 -8 -8]'

#calcula-se X e V com o erro para analisar V
X = inv(A'*A)*A'*Le 
V = A*X - Le

#descobre-se o resíduo de maior valor e sua posição
[m k] = max(abs(V))

#adiciona-se o termo G na matriz A
Add = zeros(9, 1);
Add(k) = -1;
A = cat(2, A, Add);

#calcula-se X e V com o novo termo G
X = inv(A'*A)*A'*Le
V = A*X - Le