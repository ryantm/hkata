module Kata where

import Data.List as L
import Debug.Trace

maze1 :: [[Int]]
maze1 = [[1,1,1,1,1,1,1],
        [1,0,0,0,0,0,3],
        [1,0,1,0,1,0,1],
        [0,0,1,0,0,0,1],
        [1,0,1,0,1,0,1],
        [1,0,0,0,0,0,1],
        [1,2,1,0,1,0,1]]

maze2 :: [[Int]]
maze2 = [[0,3,0,0,1,0],
         [0,2,0,1,1,0],
         [1,1,0,0,0,0],
         [0,0,0,0,0,0],
         [1,1,1,1,1,1],
         [1,0,1,1,0,0]]

direction :: [Char]
direction = ['N','N','N','N','N','E','E','E','E','E']

-- |
-- >>> startCoords maze1 0
-- (1,6)
-- >>> startCoords maze2 0
-- (1,1)
startCoords :: [[Int]] -> Int -> (Int, Int)
startCoords (row:rest) indexY =
  case L.findIndex (==2) row of
    Just indexX -> (indexX, indexY)
    Nothing -> startCoords rest (indexY+1)
startCoords _ _ = error "invalid start coordinates"

-- |
-- >>> mazeRunner maze1 direction
-- "Finish"
-- >>> mazeRunner maze1 ['N','N','N','N','N','E','E','S','S','E','E','N','N','E']
-- "Finish"
-- >>> mazeRunner maze1 ['N','N','N','N','N','E','E','E','E','E','W','W']
-- "Finish"
-- >>> mazeRunner maze1 ['N','N','N','W','W']
-- "Dead"
-- >>> mazeRunner maze1 ['N','N','N','N','N','E','E','S','S','S','S','S','S']
-- "Dead"
-- >>> mazeRunner maze1 ['N','E','E','E','E']
-- "Lost"
-- >>> mazeRunner maze2 "WENSSEESESNWWWNWSNWWEESEWWSNSNNEEEWW"
-- "Finish"
mazeRunner :: [[Int]] -> [Char] -> [Char]
mazeRunner maze = go (startCoords maze 0)
  where
    height = length maze
    width = length (head maze)

    inBounds :: (Int,Int) -> Bool
    inBounds (x,y) = x < width && y < height && x >= 0 && y >= 0

    spot :: (Int,Int) -> Maybe Int
    spot (x,y) | inBounds (x,y) = Just $ maze !! y !! x
               | otherwise = Nothing

    newCoords :: Char -> (Int,Int) -> (Int,Int)
    newCoords 'N' (x,y) = (x, y - 1)
    newCoords 'S' (x,y) = (x, y + 1)
    newCoords 'E' (x,y) = (x + 1, y)
    newCoords 'W' (x,y) = (x - 1, y)
    newCoords dir _ = error (dir : " is an invalid direction")

    go :: (Int,Int) -> [Char] -> [Char]
    go _ [] = "Lost"
    go coords (dir:dirs) =
      let nc = newCoords dir coords in
      case spot nc of
        Just 0 -> go nc dirs
        Just 2 -> go nc dirs
        Just 3 -> "Finish"
        _ -> "Dead"
