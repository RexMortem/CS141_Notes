-- type variables must be lower-case
eqPairs :: (Eq a, Eq b) => (a,b) -> (a,b) -> Bool 
eqPairs (x1, y1) (x2, y2) = (x1 == x2) && (y1 == y2)

data Vector3 = Components Float Float Float

{-
    We could use deriving Show, but then we wouldn't have this cooler print format 
-}
instance Show Vector3 where 
    show (Components x y z) = '<':show x ++ ", " ++  show y ++ ", " ++ show z ++ ">" 

instance Eq Vector3 where
    (Components a b c) == (Components d e f) = (a == d) && (b == e) && (c == f)

aVec3 = Components 5.0 4.0 2.0

