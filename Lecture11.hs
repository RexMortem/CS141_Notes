-- when we make a function an `operator`, it is left associative (like functions)

exp' :: (Num a, Integral b) => a -> b -> a
exp' x y = x^y 

res = 2 `exp'` 3 `exp'` 4 -- 4096 = (2^3)^4

addWeird :: (Num a) => a -> a -> a
addWeird x y = x + y*2

res2 = 2 `addWeird` 3 `addWeird` 4 -- 16 = (2 `addWeird` 3) `addWeird` 4 = (2 + 3*2) + 4*2 = (2+6) + 8 

useFunction :: (a -> b) -> a -> b
useFunction f = f 

-- infix operators cannot be passed as parameters (use () to convert them into functions first)