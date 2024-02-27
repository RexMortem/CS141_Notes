{-
    Algebra definition, Cardinality, Sum Types, Product Types, Either datatype, Tagged Unions, newtype (wrapper types),
    nominality, type synonyms (type alias)
-}

{-
    An algebra is a system in which you assign meaning to symbols, define relationships between symbols, and operations between them.
-}

{-  WHERE DO TYPES COME FROM?

    1) Primitives
    2) Constructors 
    3) Functions 

    Covering: 

    4) Sum type
    5) Product type
-}

{-  CARDINALITY

    Set theory: cardinality is number of elements in a set.
    Type theory: cardinality of a type is number of values that exist in the type. 
-}

{-  SUM TYPES

    Sum types are one of several possible options. For example:
-}

data Bool = False | True

{-
    This is a sum type of cardinality 2
-}

{-  PRODUCT TYPES

    Product types have constructors with parameters. 
    Cardinality is calculated by the product of cardinalities of each parameter (hence product).
-}

data TwoBools = TwoBools Bool Bool 

{-
    The cardinality of this is 4 because there are 4 possible values of TwoBools (2x2 since each Bool has 2 options).
-}

--  EXAMPLE OF COMBINING SUM AND PRODUCT 

data SomeBools = NoBools | OneBool Bool | TwoBools Bool Bool 

{-
    Therefore, there are 4 + 2 + 1 = 7 possible values s
    Cardinality = 7
-}

data Either a b = Left a | Right b 

-- Either is strictly more powerful than maybe as it can represent maybe and more 

{-  TAGGED UNIONS

    Sum Types are TAGGED unions which means what constructor was used is recorded (therefore Left "ben" ==/== Right "ben")
    (==/==) means exactly same as in this comment (obviously == is not defined for Either here)
-}

{-  WRAPPER TYPES

    Need to redefine some functionality for an existing type?
    Wrap it in some unary constructor. 
    
    Haskell is a NOMINAL language: things with two different names cannot directly interact.
    So redefining an int will create something that can't interact with int. 
-}

type String = [Char] -- this is a type alias !!!!

-- Type aliases can be polymorphic 