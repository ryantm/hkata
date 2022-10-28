{-# LANGUAGE ScopedTypeVariables #-}
module Kata where

-- https://www.codewars.com/kata/544675c6f971f7399a000e79

-- We need a function that can transform a string into a number. What
-- ways of achieving this do you know?

-- Note: Don't worry, all inputs will be strings, and every string is
-- a perfectly valid representation of an integral number.

-- Examples

-- "1234" --> 1234
-- "605"  --> 605
-- "1405" --> 1405
-- "-7" --> -7


import Data.List (findIndex)
import Data.Maybe (fromMaybe)


-- |
-- >>> stringToNumber "0"
-- 0
-- >>> stringToNumber "1"
-- 1
-- >>> stringToNumber "2"
-- 2
-- >>> stringToNumber "3"
-- 3
-- >>> stringToNumber "4"
-- 4
-- >>> stringToNumber "5"
-- 5
-- >>> stringToNumber "6"
-- 6
-- >>> stringToNumber "7"
-- 7
-- >>> stringToNumber "8"
-- 8
-- >>> stringToNumber "9"
-- 9
-- >>> stringToNumber "10"
-- 10
-- >>> stringToNumber "1234"
-- 1234
-- >>> stringToNumber "1405"
-- 1405
-- >>> stringToNumber "-7"
-- -7
-- >>> stringToNumber "-20"
-- -20
stringToNumber :: String -> Integer
stringToNumber ('-':ds) = -1 * stringToNumber ds
stringToNumber s = go (reverse s) 1
  where
    go [] _ = 0
    go (d:ds) multiplier =
      multiplier * (fromDigit d) + go ds (multiplier * 10)
    fromDigit d = fromIntegral $
      fromMaybe (error ('\'' : d : "' is not a valid digit"))
        (findIndex (==d) "0123456789")
