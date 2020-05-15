module Kata where

-- | digits of a number
--
-- >>> digitsOf 16
-- [1,6]
--
-- >>> digitsOf 942
-- [9,4,2]
digitsOf :: Integral a => a -> [a]
digitsOf num
  | num < 10 = [num]
  | otherwise = digitsOf rest <> [ digit ]
  where
    (rest, digit) = num `divMod` 10

-- | recursive sum of digits
--
-- >>> digitalRoot 16
-- 7
--
-- >>> digitalRoot 942
-- 6
--
-- >>> digitalRoot 0
-- 0
--
-- >>> digitalRoot 195
-- 6
--
-- >>> digitalRoot 992
-- 2
--
-- >>> digitalRoot 999999999999
-- 9
--
-- >>> digitalRoot 167346
-- 9
digitalRoot :: Integral a => a -> a
digitalRoot num
  | num < 10 = num
  | otherwise = digitalRoot $ sum $ digitsOf num
