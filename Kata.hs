{-# LANGUAGE ScopedTypeVariables #-}
module Kata where

import Control.Category

-- https://www.codewars.com/kata/5264d2b162488dc400000001/train/haskell

-- Write a function that takes in a string of one or more words, and
-- returns the same string, but with all five or more letter words
-- reversed (Just like the name of this Kata). Strings passed in will
-- consist of only letters and spaces. Spaces will be included only
-- when more than one word is present.

-- Examples:

-- spinWords( "Hey fellow warriors" ) => returns "Hey wollef sroirraw" 
-- spinWords( "This is a test") => returns "This is a test" 
-- spinWords( "This is another test" )=> returns "This is rehtona test"

-- |
--
-- >>> spinWords "Hell"
-- "Hell"
-- >>> spinWords "Hello"
-- "olleH"
-- >>> spinWords "Hello world"
-- "olleH dlrow"
spinWords :: String -> String
spinWords = words >>> map maybeReverse >>> unwords
  where
    maybeReverse = applyIf (\a -> length a >= 5) reverse
    -- maybeReverse word | length word >= 5 = reverse word
    --                   | otherwise = word

applyIf :: (t -> Bool) -> (t -> t) -> t -> t
applyIf p f a = if p a then f a else a
