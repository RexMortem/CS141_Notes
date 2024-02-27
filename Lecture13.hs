-- recursive data types, Foldable, Functors

data Digit = One | Two | Three | Four | Five | Six | Seven | Eight | Nine | Zero deriving Show

data UnsignedInt = SingleDigit Digit | Cons Digit UnsignedInt deriving Show

data MyList a = Empty | Cons a (MyList a)

class MyFoldable t where 
    foldr :: (a -> b -> b) -> b -> t a -> b -- new type thing: type which is parameterised by a (t a)

instance MyFoldable MyList where 
    -- make MyList

class MyFunctor f where -- functors can be mapped over (iterable)
    fmap :: (a -> b) -> f a -> f b -- for functors f which are parameterised by types a and b 


{-
    Typeclass laws: rules for typeclass instances to be legal. 
    Must be checked by hand womp womp :(

    Legal functor instances: 
    1) Structure-preserving: Output is same shape as input so list through map forms a list 
    2) Identity law: fmap id === id 
    3) Distributivity of fmap over (.): fmap (f . g) === fmap f . fmap g

    Typeclass laws for Foldable are beyond the scope of CS141 

    Maybe fulfills the functor laws
-}

data MyMaybe a = Nil | Only a 

instance MyFunctor MyMaybe where
    fmap :: (a -> b) -> Maybe a -> Maybe b 
    
instance MyFunctor MyMaybe where 
    foldr f z Nothing = z 
    foldr f z (Just x) = f z x -- z x order because function is (a -> b -> b) -> b -> Maybe a -> b