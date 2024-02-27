-- Records, more on Newtype, data-orientated programming 

{-
    We can use record syntax to provide names to parameters. This can help us be clear what arguments are which.
    Having to remember order for constructing a data type can lead to MISTAKES!!!

    Record syntax is syntactic sugar 
-}

data Rectangle = Rect {
    width :: Int, -- accessor function (brings a whole new function for each field into scope)
    height :: Int 
} deriving Show 

data Rectangle' = Rect' Int Int deriving Show -- different outputs from Show 

area :: Rectangle -> Int 
area aRectangle = width aRectangle * height aRectangle

area' :: Rectangle' -> Int 
area' (Rect' x y) = x * y -- for some reason x,y here can be named as the same as the width, height accessor functions  

data Square = Square {
    -- width :: Int -> Multiple declarations of "width" error
    squareWidth :: Int -- no clash
}

{-
    Prefixes to accessor functions are a solution to name clashes 
    You can also use imports (?)
-}

changeWidth :: Int -> Rectangle -> Rectangle 
changeWidth newWidth aRectangle = aRectangle {width = newWidth} -- syntactic sugar for: 

changeWidth' :: Int -> Rectangle' -> Rectangle' 
changeWidth' newWidth (Rect' width height) = Rect' newWidth height 

-- lazy languages are hard to debug because order of evaluation is hard to trace as they are evaluated when needed

{-  CONSTRAINTS FOR NEWTYPE

    - One constructor 
    - Constructor must have one parameter
-}

newtype Backwards = Backwards {
    wrappedString :: String
}

instance Show Backwards where 
    show :: Backwards -> String 
    show = reverse.show.wrappedString -- adding show here to leverage String's show function wrapping it in quotes; through this, show.reverse would give the same reuslt


-- Backwards is a wrapper to provide different show functionality 

-- This is data-orientated programming; instead of thinking about state, think about how data is threaded through functions
-- top-down, type-driven programming : first, define what you want and then think about the step-wise transformations you need to transmute data

-- NEXT LECTURE: what are the types of types 

-- LECTURE NOTES TIME 

data Module = CS141 | CS139 deriving Show -- could've made Module a type alias for String 

data Student = Student String String (Maybe String) [Module] deriving Show 
-- awkward because no names and only types (what does each String represent? Is it a gender or name?)

-- we can get a sense through comments or an example
me :: Student 
me = Student "Edward" "Denton" (Just "Ed") [CS141, CS139]

-- however it is still easy to make mistakes (for example, swapping last and first name's order)
-- could make a newtype for each field (e.g. FirstName, LastName) but this is awkward to use 
-- (having to enforce types, instancing types in order to build a Student etc.)

-- also accessing properties is a PAIN (method to access each property?)

accessName :: Student -> String 
accessName (Student fn ln _ _) = fn ++ " " ++ ln
-- enter records: the best syntactic sugar 

data Student' = Student' {firstName :: String, lastName :: String, preferredName :: Maybe String, modules :: [Module]} deriving Show
-- even the default Show implementation is more ergonomic! 

{-
    Naming the fields has three main effects:
    - it is harder to confuse the fields, so no more accidentally setting first name to last name
    or trying to understand what a field is judging by its type. 
    In other words, knowing what a field *is* exactly is much easier now that it's defined 

    - it is much easier to access each field using accessor methods

    - the syntax is nicer 
-}

me' :: Student' 
me' = Student' { -- so ergonomic 
    firstName = "Edward", 
    lastName = "Denton",
    preferredName = Just "Ed",
    modules = [CS139, CS141]
}

-- Ex 1 

data Module' = Module' {
    code :: String, 
    year :: [Int], -- years that you can take the module in 
    cats :: Int, 
    department :: String 
} deriving Show 

cs141 :: Module' 
cs141 = Module' {
    code = "141",
    year = [1],
    cats = 15, 
    department = "CS"
}

cs139 :: Module' 
cs139 = Module' {
    code = "139",
    year = [1],
    cats = 15,
    department = "CS"
}

-- REMEMBER ADTs are capitalised and so are their constructors!! In this sense, constructors aren't normal functions
-- ALSO you need to use a constructor!! 

cs126 :: Module' 
cs126 = Module' {
    code = "126",
    department = "CS",
    cats = 15,
    year = [1]
}

cs133 :: Module' 
cs133 = Module' {
    year = [1],
    department = "CS",
    code = "133",
    cats = 15
}