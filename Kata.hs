module Kata where

-- | splitHalf
--
-- >>> splitHalf [1, 2, 5, 7, 2, 3, 5, 7, 8]
-- ([1,2,5,7],[2,3,5,7,8])
splitHalf :: [a] -> ([a],[a])
splitHalf l = splitAt (length l `div` 2) l

-- | splitAndAdd
--
-- >>> splitAndAdd [1] 0
-- [1]
--
-- >>> splitAndAdd [1] 1
-- [1]
--
-- >>> splitAndAdd [1, 2] 0
-- [1,2]
--
-- >>> splitAndAdd [1, 2] 1
-- [3]
--
-- >>> splitAndAdd [1, 2, 3] 1
-- [2,4]
--
-- >>> splitAndAdd [1, 2, 3] 2
-- [6]
--
-- >>> splitAndAdd [1,2,3,4,5] 2
-- [5,10]
-- >>> splitAndAdd [1,2,3,4,5] 3
-- [15]
-- >>> splitAndAdd [15] 3
-- [15]
-- >>> splitAndAdd [32,45,43,23,54,23,54,34] 2
-- [183,125]
-- >>> splitAndAdd [32,45,43,23,54,23,54,34] 0
-- [32,45,43,23,54,23,54,34]
-- >>> splitAndAdd [3,234,25,345,45,34,234,235,345] 3
-- [305,1195]
-- >>> splitAndAdd [3,234,25,345,45,34,234,235,345,34,534,45,645,645,645,4656,45,3] 4
-- [1040,7712]
-- >>> splitAndAdd [23,345,345,345,34536,567,568,6,34536,54,7546,456] 20
-- [79327]
splitAndAdd :: [Int] -> Int -> [Int]
splitAndAdd l 0 = l
splitAndAdd [i] _ = [i]
splitAndAdd l n = splitAndAdd summed (n-1)
  where
    (s1,s2) = splitHalf l
    eqLen = length s1 == length s2
    paddedS1 = if eqLen
               then s1
               else [0] ++ s1
    summed = zipWith (+) paddedS1 s2
