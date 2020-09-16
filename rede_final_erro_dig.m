pkg load statistics

#Equações originais
A = [1 0 0 0 ;
     0 1 0 0 ;
     -1 1 0 0;
     -1 0 1 0;
     0 -1 1 0;
     0 -1 0 1;
     0 0 -1 1;
     0 0 -1 0;
     0 0 0 -1];
     
#observações     
L = [3.541 1.877 -1.664 -2.394 -0.730 -4.021 -3.291 -3.147 0.144]';

#componente do erro aleatório
#rnd foi gerada aleatoriamente, colocou-se aqui um vetor específico para a reprodutibilidade dos testes
rnd = [-0.027   0.013   0.057   0.053  -0.175  -0.102  -0.080  -0.040  -0.057]';
L = L + rnd;

#adicionar o componente aleatório
for j = 1:(length(L))
   L(j) = L(j) + normrnd(0, 7e-5, 1);
endfor

#escolhe uma equação para introduzir o erro
i = round(9*rand(1));


#introduz o erro na equação escolhida
Le = L;
strLe = num2str(Le(i))

do
   i2 = round(length(strLe)*rand(1));
   i3 = round(length(strLe)*rand(1));

   if strLe(1) == '-' #p/não trocar de lugar o sinal negativo
      if i2 == 1
         i2++;
      endif
      if i3 == 1
         i3++;
      endif
   endif
until (i2 != i3 & [i2 i3] != zeros(1,2))

c = strLe(i2);
strLe(i2) = strLe(i3);
strLe(i3) = c;

Le(i) = str2num(strLe);

#observações acrescidas das estações conhecidas
Le = Le + [10 10 0 0 0 0 0 -8 -8]';

#calcula-se X e V com o erro para analisar V
X = inv(A'*A)*A'*Le 
V = A*X - Le
(norm(V))^2

#descobre-se o resíduo de maior valor e sua posição
[m k] = max(abs(V))

#adiciona-se o termo G na matriz A
Add = zeros(9, 1);
Add(k) = -1;
A = cat(2, A, Add);

#calcula-se X e V com o novo termo G
X = inv(A'*A)*A'*Le
V = A*X - Le

(norm(V))^2