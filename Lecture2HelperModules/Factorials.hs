-- contains 5 different definitions of factorial (standard case, cases w/o braces, guards, top-level pattern matching, if else)
module Lecture2HelperModules.Factorials where

factorial :: Int -> Int
factorial x = case x of { -- standard by cases
    0 -> 1; 
    _ -> x * factorial (x-1)
}

fac :: Int -> Int
fac x = case x of 
    0 -> 1
    n -> n * fac (n-1)

-- shortening factorial to fac is a sin against humanity 
fac' :: Integer -> Integer
fac' x | x == 0 = 1 | otherwise = x * fac'(x - 1) -- using guards 

fac'' :: Integer -> Integer 
fac'' 0 = 1 -- simple pattern match 
-- can't put a function like double x = x + x inbetween patterns
fac'' x = x * fac'' (x-1)

fac''' :: Integer -> Integer
fac''' x = if x == 0 then 1 else x * fac''' (x-1) -- use if else 
