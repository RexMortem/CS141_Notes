-- semigroups

{-
    Typeclasses exist to abstract over common behaviours. 

    A semigroup is a set with a binary operation (+) that is associative
    The idea related to (+) is combining 

    a + (b + c) = (a + b) + c 

    (+) is often used for the semigroup operation, however Num uses (+) 
    We use <> instead. 
-}

class Semigroup a where 
    -- MINIMAL <>
    (<>) :: a -> a -> a 

{-
    From our previous description of the operator, we know:

    (a <> b) <> c = a <> b <> c = a <> (b <> c)

    For lists, the semigroup operation is (++) as it takes two lists and combines them.
    It is associative. 
-}

instance Semigroup [a] where 
    (<>) = (++)

{-  
    Sets form a semigroup under two operations: union and intersection.  
-}

instance (Semigroup a, Semigroup b) => Semigroup (a,b) where 
    (<>) :: (Semigroup a, Semigroup b) => (a,b) -> (a,b) -> (a,b)
    (a,b) <> (c,d) = (a <> c, b <> d)

instance Semigroup a => Semigroup (Maybe a) where 
    Nothing <> Nothing = Nothing 
    Just x <> Nothing = Just x 
    Nothing <> Just y = Just y
    Just x <> Just y = Just $ x <> y 

{-
    There are many possible definitions for a semigroup operation here. 
    ... 
-}

{-
    Monoids are semigroups plus we also have an identity element. 

    mempty is the identity element 
-}

class Semigroup a => Monoid a where 
    mempty :: a 

-- since it is REQUIRED to be part of Semigroup to be a Monoid 

{-
    Monoid is a *subclass* of Semigroup (as it is required to be a Semigroup to be a Monoid)

    x <> mempty === x
    mempty <> x === x 

    This is a typeclass law for Monoid (don't break it pls)

    The MONOID laws: semigroup laws and identity laws
-}

{- SET MONOID
    Sets do not form a Monoid under intersection.
    This is because an identity element cannot exist (unless you have a set containing everything)

    Sets do form a Monoid under union however as it's the empty set 
-}

{-  NUMBER MONOID

    Numbers are too monoidal because there are two possible operations and identity elements 

    (+, 0), (*, 1) are both valid 

    The solution chosen was to provide two polymorphic newtype wrappers 
-}

newtype Sum a = Sum {getSum :: a}

-- then, we define the monoid opt-in for each of these 

instance Num a => Semigroup (Sum a) where 
    (<>) = (+)