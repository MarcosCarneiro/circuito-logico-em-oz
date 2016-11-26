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

local X Y N O A Na No Xo in
   X = 1|1|0|0|_
   Y = 0|1|0|1|_
   
end