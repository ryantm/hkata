module Kata where

import qualified Control.Foldl as L
import Data.Maybe (fromJust)
import Text.Parsec

-- | returns the max and min number of a list
-- >>> highAndLow "1"
-- "1 1"
-- >>> highAndLow "2"
-- "2 2"
-- >>> highAndLow "1 2"
-- "2 1"
-- >>> highAndLow "1 2 3 4 5"
-- "5 1"
-- >>> highAndLow "1 2 -3 4 5"
-- "5 -3"
highAndLow :: String -> String
highAndLow input = result
  where
    result = show max <> " " <> show min
    numbers :: [Int]
    numbers = fmap read (words input)
    (max, min) = maxMin numbers
    maxMin :: [Int] -> (Int, Int)
    maxMin numbers = foldl f (minBound, maxBound) numbers
    f (currentMax, currentMin) currentNumber =
      (maximum [currentMax, currentNumber], minimum [currentMin, currentNumber])
