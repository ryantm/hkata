module Kata where

-- |
-- >>> bouncingBall 0 undefined undefined
-- -1
-- >>> bouncingBall 1 0 undefined
-- -1
-- >>> bouncingBall 1 1 undefined
-- -1
-- >>> bouncingBall 1 0.5 2
-- -1
-- >>> bouncingBall 3 0.66 1.5
-- 3
-- >>> bouncingBall 30.0 0.66 1.5
-- 15
bouncingBall :: Double -> Double -> Double -> Integer
bouncingBall height bounce window
  | height <= 0 = -1
  | bounce <= 0 || bounce >= 1 = -1
  | window >= height = -1
  | otherwise = 2 + bouncingBall (height * bounce) bounce window
