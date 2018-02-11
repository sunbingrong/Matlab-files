
function f = Boundary_Condition( f, x, t )
if Problem == 0, f(1)     = Exact_Solution( x(1), t)     ; end
if Problem == 1, f([1,N]) = 0                            ; end
if Problem == 2, f(1,:)= 0; f(:,1) = f(:,end)   ; end
end