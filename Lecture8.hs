-- use as general a type as possible (typeclasses :) )
-- Referential Transparency (BIG IMPORTANT)

sum' :: (Num a) => [a] -> a 
sum' [] = 0
sum' (x:xs) = x + sum' xs

map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <- xs]