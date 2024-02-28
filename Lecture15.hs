-- Records, more on Newtype, data-orientated programming 

{-  NOTE

    The lecture note section starts at line 69
    I would recommend reading the lecture note part rather than the lecture part 
-}

{-
    We can use record syntax to provide names to parameters. This can help us be clear what arguments are which.
    Having to remember order for constructing a data type can lead to MISTAKES!!!

    Record syntax is syntactic sugar for ADTs
-}

data Rectangle = Rect {
    width :: Int, -- accessor function (brings a whole new function for each field into scope)
    height :: Int 
} deriving Show 

data Rectangle' = Rect' Int Int deriving Show -- different outputs from Show 

area :: Rectangle -> Int 
area aRectangle = width aRectangle * height aRectangle

area' :: Rectangle' -> Int 
area' (Rect' x y) = x * y -- for some reason x,y here can be named as the same as the width, height accessor functions (local scope?) 

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

    - One data constructor 
    - Data Constructor must have one parameter
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
-- enter records: the coolest syntactic sugar 

data Student' = Student' {firstName :: String, lastName :: String, preferredName :: Maybe String, modules :: [Module]} deriving Show

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

-- even the default Show implementation is more readable!! ->
-- me: Student "Edward" "Denton" (Just "Ed") [CS141,CS139]
-- me': Student' {firstName = "Edward", lastName = "Denton", preferredName = Just "Ed", modules = [CS139,CS141]}

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

-- REMEMBER ADTs are capitalised and so are their data constructors!! In this sense, data constructors aren't normal functions

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

-- since record syntax IS just syntactic sugar, we can use the data constructor in the less ergonomic way as well

cs118 :: Module' 
cs118 = Module' "118" [1] 15 "CS" -- this DOES need to be in order though 

getFullModuleCode :: Module' -> String 
getFullModuleCode (Module' code _ _ dept) = dept ++ code -- can use less ergonomic way to access fields 

-- let's use accessors though; we get these accessors for Module' : 

{-
    code :: Module' -> String 
    year :: Module' -> [Int]
    cats :: Module' -> Int 
    department :: Module' -> String
-}

-- WARNING: field names can clash as accessor functions are placed in the same scope as its ADT 
-- ADTs can't be declared inside a where binding 
-- common solution is variable naming convention: put name of thing as a prefix e.g. 

data Animal = Dog {
    animalName :: String, 
    animalAge :: Int
} | Cat {
    animalName :: String, 
    animalAge :: Int
} deriving Show

data Person = Person {
    personName :: String, -- if we put this as animalName then it would be a multiple declarations error!! 
    personAge :: Int 
} deriving Show 

{-  UPDATING RECORDS

    Previously, we had to deconstruct and reconstruct ADTs to change even a single field
    Now, we can use record syntax which is much easier for large ADTs (imagine updating an ADT with 5+ fields)
-}

updateAge :: Int -> Person -> Person 
updateAge newAge (Person name _) = Person name newAge -- old way 

updateAge' :: Int -> Person -> Person 
updateAge' newAge ourADT = ourADT {personAge = newAge} -- don't have to reconstruct!!!
{-
    In GHCI:
    a = Person "Ed" 18
    b = a {personAge = 19}
-}

changeDepartment :: String -> Module' -> Module' 
changeDepartment newDept aModule = aModule {department = newDept}

updateYears :: Module' -> Module' 
updateYears aModule = let 
                          yearToAdd = read [(head.code) aModule] :: Int
                          newYear :: [Int]
                          newYear = if yearToAdd `elem` year aModule then year aModule else yearToAdd : year aModule 
                      in aModule {year = newYear}

-- probably best to use a where clause for yearToAdd combined with a guard clause (or a case of)

{-  NEWTYPE

    Used for wrapping types mainly (adding extra or different functionality to existing types, or just to distinguish them)
    Newtype is for special cases of ADTs: single data constructor with a single parameter

    For example, I have written the binary ADT whose main purpose is to change Show so that its string representation
    is the binary version of the number. 
    
    Due to type erasure, there is no extra cost incurred by using Cm or Mm as opposed to using Integers. 
-}

newtype Cm = ToCm {
    fromCm :: Integer 
}

newtype Mm = ToMm {
    fromMm :: Integer 
}

newtype Binary = ToBinary {
    fromBinary :: Integer 
}

buildBinaryString :: Binary -> String 
buildBinaryString bn
    | n == 0 = ""
    | otherwise = bit : buildBinaryString binaryResult 
    where 
          n :: Integer 
          n = fromBinary bn 

          (result, remainder) = divMod n 2 
          
          bit :: Char 
          bit = if remainder == 0 then '0' else '1' 

          binaryResult :: Binary 
          binaryResult = ToBinary result

instance Show Binary where 
    show :: Binary -> String 
    show = reverse.buildBinaryString

{- 
    To make it easier to think about kinds next lecture, know that Binary is a TYPE 

    We create a value of type Binary using Binary's data constructors 
    In this case, as it is a newtype, there is only one data constructor: ToBinary 

    So in:

    newtype Binary = ToBinary Integer 

    left-side is a type
    right-side has data constructor 
-}

data LinkedList a = EmptyList | Singleton a | Prepend a (LinkedList a) deriving Show

{-
    For this, we also have a type variable. LinkedList is no longer just a type because we can have several LinkedLists of different types.
    For instance, LinkedList String is not the same type as LinkedList Integer.

    Similarly, it does not make sense to have a list of type LinkedList. 
    It needs to be a list containing *something* whether it's a String or Bool or Int. 

    So what is LinkedList? It's a type constructor. 
    It takes in a type variable (a) and produces a new type (LinkedList a)! 
    It still has data constructors and these create values of the type specified by the type constructor. 

    We know that each of the data constructors are basically functions and therefore have types:

    EmptyList :: LinkedList a 
    Singleton :: a -> LinkedList a 
    Prepend :: a -> LinkedList a -> LinkedList a

    But the parameters of the type constructor LinkedList are types themselves. So what is the type of the type constructor?
    That is the subject of the next lecture: kinds. 
-}