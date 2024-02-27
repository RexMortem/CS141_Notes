-- Kinds: types of types 

{-
    Note that * will be replaced by Type in the future 
-}

import Prelude hiding (Maybe, Just, Nothing) 


data Maybe a = Just a | Nothing 

{-
    The ADT Maybe does not have a type because it is a type constructor: it has a kind. 
    Type constructors are not functions in the traditional sense because they have a kind instead of a type. 
    You also don't use the type constructors to construct the new type; you call its constructors. 

    Type constructors take in types and return a new type. 

    Maybe :: * -> * 

    Its constructors have types. They can be different types. The constructors are just functions.

    Just :: a -> Maybe a 
    Nothing :: Maybe a 

    Nothing is polymorphic so it's generic as possible so can be matched with lots of different types
-}


data Vector = Vector2D Int Int | Vector3D Int Int Int 

{-
    Vector :: * 

    This is because a value of Vector always :: Vector. 
    There are no type variables involved with Vector; the values of Vector are always :: Vector. 
    This is regardless of whether the shape is Vector2D Int Int or Vector3D Int Int Int. Its shape/type is still :: Vector.  
    In this way, Vector is a nullary type constructor.
-}