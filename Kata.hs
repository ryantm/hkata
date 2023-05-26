{-# LANGUAGE ScopedTypeVariables #-}
module Kata where

-- import Data.List

-- https://www.codewars.com/kata/5a24fff71f7f7051bd000097/train/haskell

-- 1 1 ? ?  ? 2 2 ?  ? ? 3 3
-- 1 1 ? ?  ? 2 2 ?  ? ? 3 3
-- ? ? ? ?  ? ? ? ?  ? ? ? ?
-- ? ? ? ?  ? ? ? ?  ? ? ? ?
--
-- ? ? ? ?  ? ? ? ?  ? ? ? ?
-- 4 4 ? ?  ? 5 5 ?  ? ? 6 6
-- 4 4 ? ?  ? 5 5 ?  ? ? 6 6
-- ? ? ? ?  ? ? ? ?  ? ? ? ?
--
-- ? ? ? ?  ? ? ? ?  ? ? ? ?
-- ? ? ? ?  ? ? ? ?  ? ? ? ?
-- 7 7 ? ?  ? 8 8 ?  ? ? 9 9
-- 7 7 ? ?  ? 8 8 ?  ? ? 9 9

data Cell = W Int | Q deriving (Show, Eq)

data Screen = Screen [[Cell]] deriving (Show, Eq)

-- |
--
-- >>> parseCell "1"
-- W 1
-- >>> parseCell "?"
-- Q
parseCell :: String -> Cell
parseCell "?" = Q
parseCell n = W (read n)

-- |
--
-- >>> parse "1 1 ? ?\n1 1 ? ?\n? ? ? ?\n? ? ? ?"
-- Screen [[W 1,W 1,Q,Q],[W 1,W 1,Q,Q],[Q,Q,Q,Q],[Q,Q,Q,Q]]
parse :: String -> Screen
parse input = Screen ((map . map) parseCell (map words (lines input)))

empty :: Screen
empty = Screen [
  [Q,Q,Q,Q],
  [Q,Q,Q,Q],
  [Q,Q,Q,Q],
  [Q,Q,Q,Q]]

-- [
-- [[1], [1, 2], [2, 3], [3] ],
-- [[1,4], [1, 2, 4, 5], [2, 3, 5, 6], [3, 5, 6] ],
-- [[4,7], [7, 8, 4, 5], [8, 9, 5, 6], [9, 5, 6] ],
-- [[7], [7, 8], [7, 8], [9] ],
-- ]

one :: Screen
one = Screen [
  [W 1,W 1,Q,Q],
  [W 1,W 1,Q,Q],
  [Q,Q,Q,Q],
  [Q,Q,Q,Q]]
two :: Screen
two = Screen [
  [Q,W 2,W 2,Q],
  [Q,W 2,W 2,Q],
  [Q,Q,Q,Q],
  [Q,Q,Q,Q]]
three :: Screen
three = Screen [
  [Q,Q,W 3,W 3],
  [Q,Q,W 3,W 3],
  [Q,Q,Q,Q],
  [Q,Q,Q,Q]]
four :: Screen
four = Screen [
  [Q,Q,Q,Q],
  [W 4,W 4,Q,Q],
  [W 4,W 4,Q,Q],
  [Q,Q,Q,Q]]
five :: Screen
five = Screen [
  [Q,Q,Q,Q],
  [Q,W 5,W 5,Q],
  [Q,W 5,W 5,Q],
  [Q,Q,Q,Q]]
six :: Screen
six = Screen [
  [Q,Q,Q,Q],
  [Q,Q,W 6,W 6],
  [Q,Q,W 6,W 6],
  [Q,Q,Q,Q]]
seven :: Screen
seven = Screen [
  [Q,Q,Q,Q],
  [Q,Q,Q,Q],
  [W 7,W 7,Q,Q],
  [W 7,W 7,Q,Q]]
eight :: Screen
eight = Screen [
  [Q,Q,Q,Q],
  [Q,Q,Q,Q],
  [Q,W 8,W 8,Q],
  [Q,W 8,W 8,Q]]
nine :: Screen
nine = Screen [
  [Q,Q,Q,Q],
  [Q,Q,Q,Q],
  [Q,Q,W 9,W 9],
  [Q,Q,W 9,W 9]]

rowsToScreen :: [Cell] -> Screen
rowsToScreen c =
  Screen [rowone, rowtwo, rowthree, rowfour]
  where
    rowone = take 4 c
    rowtwo = take 4 (drop 4 c)
    rowthree = take 4 (drop 8 c)
    rowfour = take 4 (drop 12 c)

-- >>> fore one two
-- Screen [[W 1,W 2,W 2,Q],[W 1,W 2,W 2,Q],[Q,Q,Q,Q],[Q,Q,Q,Q]]
fore :: Screen -> Screen -> Screen
fore (Screen s) (Screen f) =
  let
    scells = concat s
    fcells = concat f
    merge :: Cell -> Cell -> Cell
    merge Q Q = Q
    merge c Q = c
    merge _ c = c
  in
    rowsToScreen (zipWith merge scells fcells)

allWindows :: [Screen]
allWindows = [one,two,three,four,five,six,seven,eight,nine]




-- windowsClicked :: Screen -> [Screens]
-- windowsClicked




-- [
-- [[1], [1, 2], [2, 3], [3] ],
-- [[1,4], [1, 2, 4, 5], [2, 3, 5, 6], [3, 5, 6] ],
-- [[4,7], [7, 8, 4, 5], [8, 9, 5, 6], [9, 5, 6] ],
-- [[7], [7, 8], [7, 8], [9] ],
-- ]

-- |
--
-- >>> isValid "1 1 ? ?\n1 1 ? ?\n? ? ? ?\n? ? ? ?"
-- True
-- >>> isValid "? 2 2 ?\n? 2 2 ?\n? ? ? ?\n? ? ? ?"
-- True
-- >>> isValid "1 2 2 ?\n? 2 2 ?\n? ? ? ?\n? ? ? ?"
-- False
-- >> isValid "1 2 3 3\n4 5 6 6\n7 8 9 9\n7 8 9 9"
-- True
isValid :: String -> Bool
isValid input =
  let
    Screen s = parse input
    rules = [
      (if (s !! 0 !! 0) == Q
       then
          (s !! 0 !! 1) /= W 1 &&
          (s !! 1 !! 0) /= W 1 &&
          (s !! 1 !! 1) /= W 1
        else
          (s !! 0 !! 1) /= Q &&
          (s !! 1 !! 0) /= Q &&
          (s !! 1 !! 1) /= Q
       )
      ]
  in
    all id rules


  --   -- search :: Screen -> Screen -> Bool
  --   -- search acc target | acc == target = True
  --   --                   | otherwise =
  -- in
  --   (s `elem` [one,two,three,four,five,six,seven,eight,nine]) || search empty s



-- [
-- [[1], [1, 2], [2, 3], [3] ],
-- [[1,4], [1, 2, 4, 5], [2, 3, 5, 6], [3, 5, 6] ],
-- [[4,7], [7, 8, 4, 5], [8, 9, 5, 6], [9, 5, 6] ],
-- [[7], [7, 8], [7, 8], [9] ],
-- ]



        -- isValid "1 1 3 3\n1 1 3 3\n7 7 9 9\n7 7 9 9" `shouldBe` True
        -- isValid "1 1 3 3\n4 1 3 3\n7 7 9 9\n7 7 9 9" `shouldBe` False
        -- isValid "1 1 3 3\n1 5 5 3\n7 5 5 9\n7 7 9 9" `shouldBe` True
        -- isValid "1 2 2 3\n1 5 5 3\n7 5 5 9\n7 8 8 9" `shouldBe` True
        -- isValid "1 2 2 3\n1 2 2 3\n7 8 8 9\n7 7 9 9" `shouldBe` False
        -- isValid "1 2 2 3\n4 5 6 6\n4 8 6 6\n7 8 8 9" `shouldBe` True
