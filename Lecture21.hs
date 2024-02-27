-- Summary of previous 2 lectures, environment functor, 

safeHead :: [a] -> Maybe a 

instance Monad ((-> e)) where 
    -- (>>=) :: t a -> (a -> t b) -> t b 
    (>>=) :: (e -> a) -> (a -> (e -> b)) -> (e -> b)
    func >>= lifter = lifter.func -- compact form

    func >>= lifter = \x -> -- easiest way to return a function, is to use a lambda (eta reduction can be confusing)
        let x' = func x -- x' :: a 
        in lifter x' x -- lifter x' :: t b

{-
    Reader is for computations that share an environment (e.g. collection of input parameters)
-}

 instance Applicative (Reader e) where 
    -- pure :: a -> t a (pure is lifting function)
    pure :: a -> Reader e a 
    pure = Rd . const 
    
{-
    State
-}

type Seed = Int -- type alias 

gen :: Seed -> (Int, Seed) -- new seed (nS) seems to be random but is determined from the previous seed (cS)
gen cS = let 
    (t,u) = x `divMod` 10
    nS = t + u * 6
    res = nS
    in (res, nS) -- returns a random result (based off seed), new seed 

add3 :: Seed -> (Int, Seed)
add3 seed = let
    (x1, seed1) = gen seed 
    (x2, seed2) = gen seed1 
    (x3, seed3) = gen seed2 
    in (x1 + x2 + x3, seed3)

-- State monad is a wrapper for this as add3 has a repetitive definition 

newtype MyState s a = St (s -> (a,s)) -- State is a wrapper around a function 

wrappedGen :: MyState Seed Int 
wrappedGen = St gen 

instance Functor (MyState s) where 
    -- fmap :: (a -> b) -> t a -> t b 
    fmap :: (a -> b) -> MyState s a -> MyState s b  

    fmap f (St func) = St $ \s -> 
        let (x, s') = func s 
        in (f x, s')

instance Monad (MyState s) where 
    

add3' :: State (Seed Int) 
add3' = 
    gen' >>= \x -> 
    gen' >>= \y -> 
    gen' >>= \z -> 
    pure $ x + y + z 

-- syntactic sugar incoming 