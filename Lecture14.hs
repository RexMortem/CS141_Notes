-- trees
module Tree where 

data MyList a = None | -- analagous to []
                Cons a (MyList a) -- specifically of the same type (can't have mixed elements in the list)

instance (Show a) => Show (MyList a) where 
    show :: (Show a) => MyList a -> String 
    show None = "[]"
    show (Cons x None) = '[' : show x ++ "]"
    show (Cons x xs) = '[' : show x ++ ", " ++ tail xsString 
        where xsString = show xs

instance Functor MyList where -- let's implement our list as a functor (mappable object; see typeclass laws for functors)
    -- we know fmap :: Functor f => (a -> b) -> f a -> f b
    fmap :: (a -> b) -> MyList a -> MyList b
    fmap f None = None -- empty list maps to empty list 
    fmap f (Cons x xs) = Cons (f x) $ fmap f xs 