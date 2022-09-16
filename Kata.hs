{-# LANGUAGE ScopedTypeVariables #-}
module Kata where

-- https://www.codewars.com/kata/515de9ae9dcfc28eb6000001/train/haskell

-- Complete the solution so that it splits the string into pairs of
-- two characters. If the string contains an odd number of characters
-- then it should replace the missing second character of the final
-- pair with an underscore ('_').

-- Examples:

-- * 'abc' =>  ['ab', 'c_']
-- * 'abcdef' => ['ab', 'cd', 'ef']

-- |
-- >>> solution ""
-- []
-- >>> solution "a"
-- ["a_"]
-- >>> solution "ab"
-- ["ab"]
-- >>> solution "abc"
-- ["ab","c_"]
-- >>> solution "abcd"
-- ["ab","cd"]
-- >>> solution "abcdef"
-- ["ab","cd","ef"]
solution :: String -> [String]
solution "" = []
solution (a:"") = [[a,'_']]
solution (a:b:rest)   = [a,b]:(solution rest)































































-- >>> solution "a"
-- ["a_"]
-- >>> solution "ab"
-- ["ab"]
-- >>> solution "abc"
-- ["ab","c_"]
-- >>> solution "abcdef"
-- ["ab","cd","ef"]
