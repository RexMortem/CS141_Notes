leftToRight = [x+y | x <- [1..2], y <- [1..x]] -- list comprehensions are read left to right, so righter generators can use variables from lefter generators

{-
    haskell function to get any pair of natural numbers in order; generate diagonal at a time
    use fact that each pair in 0th diagonal sum to 0, each pair in nth diagonal sum to n
-}

enumerateN2 = [(first, second) | x <- [0..], first <- [0..x], let second = x - first]

-- get triples of naturals 
enumerateN3 = [(f, s, t) | x <- [0..], f <- [0..x], s <- [0..x], t <- [0..x], f + s + t == x]

-- writing sum without identity element bit ([] = 0)
sum' :: (Num a) => [a] -> a
sum' (x:[]) = x
sum' (x:xs) = x + sum' xs