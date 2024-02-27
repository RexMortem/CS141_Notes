-- stimes, mconcat, foldMap, Functional Programming, Functor

{-
    stimes applies value to itself (using semigroup operation) a given number of times 

    mconcat takes a list of semigroup values and combines them all (mempty for empty list)
    Analagous to folding 

    foldMap is similar to mconcat except it applies a function to every element before combining them 
    In a way, mconcat can be written -> foldMap id (eta reduction)  
-}

{-  FUNCTIONAL PROGRAMMING

    Functions are first-class values 

    (->) :: * -> * -> * 

    Function arrow takes 2 types and returns another type 
-}

{-  SEMIGROUP FOR FUNCTIONS

    We cannot use composition (.) for the semigroup operation 
    This is because functions do not have to be of the same type for composition
    Therefore, they are not the right shape 
-}

instance Semigroup b => Semigroup (a -> b) where -- b must be able to be operated on with <>
    <> :: (a -> b) -> (a -> b) -> (a -> b)
    (f <> g) x = f x <> g x 

-- application 

f :: [Char] -> [Char]
f x = [toLower n | n <- x]
    where 
          toLower n
            | 'A' = 'a' 
            | otherwise = n  

instance Monoid b => Monoid (a -> b) where 
    mempty = \_ -> mempty -- the identity function 

instance Functor ( (->) e ) where 
    -- fmap :: (a -> b) -> t a -> t b
    --fmap :: (a -> b) -> ((->) e a) -> ((->) e b)
    fmap :: (a -> b) -> (e -> a) -> (e -> b)
    fmap f g = \x -> f $ g x -- can do fmap f g x but less readable since we're returning a function 

-- environment is terminology for the domain (e for environment)