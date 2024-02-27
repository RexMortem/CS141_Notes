createList :: Int -> [Int]
createList n
    | n == 0 = []
    | otherwise = n : (createList $ n-1)

createList' :: Int -> [Int] -> [Int]
createList' n currentList 
    | n == 0 = currentList 
    | otherwise = createList' (n-1) (n:currentList)

-- FOLDR is generally used when you need to collapse a list into a single element HOWEVER you can use it to get a list from a list
-- therefore, can use foldr whenever you need to apply a function of two arguments 