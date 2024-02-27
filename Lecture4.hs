combine :: (Int, Int) -> Int
combine (x,y) = x + y -- using pattern matching 

combine' :: (Int, Int) -> Int
combine' x = fst x + snd x -- don't have to use pattern matching (although pattern matching is better)


-- if in a case where we need to unpack x into its tuple form, can use case

combine'' :: (Int, Int) -> Int 
combine'' x = case x of {
    (a,b) -> a + b; -- unpacks into tuple form (can pack using where bindings/let bindings)
}

fst' :: (a, b) -> a -- only for pairs
fst' = \(x, y) -> x

snd' :: (a,b) -> b -- only for pairs
snd' = \(x, y) -> y

startsWithFiveAndSeven :: [Int] -> Bool 
startsWithFiveAndSeven (5:7:xs) = True
startsWithFiveAndSeven _ = False 

-- alex recommends not using head and tail as they are non-total functions (non-exhaustive patterns); not well-defined

getListWithSetValue :: [a] -> Int -> a -> [a]
getListWithSetValue list index value = (take index list) 