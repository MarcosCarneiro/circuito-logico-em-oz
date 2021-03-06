%Implementacao das Portas Logicas, extraidas do livro-texto
declare
fun {NotLoop Xs}
   case Xs of X|Xr then (1-X)|{NotLoop Xr} end
end

declare
fun {NotG Xs}
   thread {NotLoop Xs} end
end

declare
fun {GateMaker F}
   fun {$ Xs Ys}
      fun {GateLoop Xs Ys}
	 case Xs#Ys of (X|Xr)#(Y|Yr) then
	    {F X Y}|{GateLoop Xr Yr}
	 end
      end
   in
      thread {GateLoop Xs Ys} end
   end
end

declare
fun {OrG Xs Ys}
   {{GateMaker fun {$ X Y} X+Y-X*Y end} Xs Ys}
end

declare
fun {AndG Xs Ys}
   {{GateMaker fun {$ X Y} X*Y end} Xs Ys}
end

declare
fun {NandG Xs Ys}
   {{GateMaker fun {$ X Y} 1-X*Y end} Xs Ys}
end

declare
fun {NorG Xs Ys}
   {{GateMaker fun {$ X Y} 1-X-Y+X*Y end} Xs Ys}
end

declare
fun {XorG Xs Ys}
   {{GateMaker fun {$ X Y} X+Y-2*X*Y end} Xs Ys}
end

%Circuito Verificador de Numero Primo
%O circuito verifica de 0 a (2^n)-1 e retorna 1 se o numero for primo e 0 caso contrario.
%Onde n eh o numero de variaveis, no caso n = 4.
%Equacao do circuito: ~(A+B)*C + ~A*C*D + ~B*C*D + B*~C*D.
%A equacao foi obtida atraves do mapa de Karnaugh utilizando o metodo de soma de produtos.

declare
fun {NumPrimo A B C D}
   local K L M N P Q in
      
      K = {AndG {NorG A B} C}
      L = {AndG {AndG {NotG A} C} D}
      M = {AndG {AndG {NotG B} C} D}
      N = {AndG {AndG B {NotG C}} D}
      
      P = {OrG K L}
      Q = {OrG M N}
      
      {OrG P Q}
   
   end
end

%Circuito Verificador de numero pertencente a sequencia de Fibonacci.
%O circuito verifica de 0 a (2^n)-1 e retorna 1 se o numero pertencer a sequencia de Fibonacci e 0 caso contrario.
%Onde n eh o numero de variaveis, no caso n = 4.
%Equacao do circuito: (~B+D)*~(B*C)*~((A*D)+C)*(~(A*C)+D)
%A equacao foi obtida atraves do mapa de Karnaugh utilizando o metodo de produto de somas e simplicado atraves do teorema de DeMorgan.
declare
fun {Fibonacci A B C D}
   local K L M N P Q in
      K = {OrG {NotG B} D}
      L = {NandG B C}
      M = {OrG {NandG A D} C}
      N = {OrG {NandG A C} D}

      P = {AndG K L}
      Q = {AndG M N}

      {AndG P Q}
   end
end


local A B C D in
   A = 0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|_
   B = 0|0|0|0|1|1|1|1|0|0|0|0|1|1|1|1|_
   C = 0|0|1|1|0|0|1|1|0|0|1|1|0|0|1|1|_
   D = 0|1|0|1|0|1|0|1|0|1|0|1|0|1|0|1|_
   
   {Browse 'Primo'}
   {Browse {NumPrimo A B C D}}

   {Browse 'Fibonacci'}
   {Browse {Fibonacci A B C D}}
   
end