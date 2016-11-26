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
%Equacao do circuito: ~(A+B)*C + ~A*C*D + ~B*C*D + B*~C*D. Obtidad atraves do mapa de Karnaugh
local A B C D J K L M N P Q R in
   A = 0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|_
   B = 0|0|0|0|1|1|1|1|0|0|0|0|1|1|1|1|_
   C = 0|0|1|1|0|0|1|1|0|0|1|1|0|0|1|1|_
   D = 0|1|0|1|0|1|0|1|0|1|0|1|0|1|0|1|_

   K = {AndG {NorG A B} C}
   L = {AndG {AndG {NotG A} C} D}
   M = {AndG {AndG {NotG B} C} D}
   N = {AndG {AndG B {NotG C}} D}

   P = {OrG K L}
   Q = {OrG M N}

   R = {OrG P Q}
   
   {Browse R}
   
end