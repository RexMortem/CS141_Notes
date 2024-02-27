module Lecture2 where 

import Lecture2HelperModules.Factorials

addOne :: Int -> Int
addOne x = x + 1

square :: Int -> Int
square = \x -> x * x

compare' :: (Ord a) => a -> a -> Ordering
compare' x y 
    | x < y = LT
    | x > y = GT
    | x == y = EQ

factorialList :: [(Int, Int)]
factorialList = [(x, factorial x) | x <- [1..100]]

factorialList' :: [(Int, Int)]
factorialList' = zip [1..100] [factorial x | x <- [1..100]]

factorialList'' :: [(Int, Int)]
factorialList'' = zip [1..100] (map factorial [1..100])

addOne' :: Int -> Int 
addOne' = \x -> x+1 -- lambda expression; without syntactic sugar 

-- we can see that addOne desugars to addOne' 

{-
    Exercises 
-}

-- Ex1 and Ex2
isItEven :: (Integral n) => n -> String
isItEven n
    | mod n 2 == 0 = "Yes :)"
    | otherwise = "No :("

isItEven' :: (Integral n) => n -> String 
isItEven' n 
    | even n == True = "Yes :)"
    | otherwise = "No :("

-- case form for isItEven (can't be used in syntactic sugar form)

isItEven'' :: (Integral n) => n -> String
isItEven'' x = case x `mod` 2 of {
    0 -> "Yes :)";
    _ -> "No :("
}

-- Ex3
sixtyFour = (\x -> x*x) 8

-- Ex4
xor :: Bool -> Bool -> Bool
xor x y 
    | (x && (not y)) || (y && (not x)) = True -- could just return this expression 
    | otherwise = False 

-- Ex5
xor' = \x -> \y -> (x && (not y)) || (y && (not x)) 

x ^^^ y = not (x == y)

-- Ex6
square' = (^2)