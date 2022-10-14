{-# LANGUAGE ScopedTypeVariables #-}
module Kata where

import Data.Ratio
import Data.List

-- https://www.codewars.com/kata/5868022b36959fa4a4000527/train/haskell

data Tarot = Oudler
           | King
           | Queen
           | Knight
           | Jack
           | Ordinary
           deriving (Show, Eq, Ord)

-- |
-- >>> toTarot '0' '0'
-- Oudler
-- >>> toTarot '0' '1'
-- Oudler
-- >>> toTarot '2' '1'
-- Oudler
-- >>> toTarot 'H' 'K'
-- King
-- >>> toTarot 'H' 'Q'
-- Queen
-- >>> toTarot 'H' 'C'
-- Knight
-- >>> toTarot 'H' 'J'
-- Jack
-- >>> toTarot '1' '0'
-- Ordinary
toTarot :: Char -> Char -> Tarot
toTarot '0' '0' = Oudler
toTarot '0' '1' = Oudler
toTarot '2' '1' = Oudler
toTarot _ 'K' = King
toTarot _ 'Q' = Queen
toTarot _ 'C' = Knight
toTarot _ 'J' = Jack
toTarot _ _ = Ordinary

-- |
-- >>> parseTarot "00"
-- [Oudler]
-- >>> parseTarot "00HK"
-- [Oudler,King]
parseTarot :: String -> [Tarot]
parseTarot (c1:c2:rest) = toTarot c1 c2 : parseTarot rest
parseTarot _ = []

-- |
-- >>> expectedScore []
-- 56 % 1
-- >>> expectedScore [Oudler]
-- 51 % 1
-- >>> expectedScore [Oudler, Oudler]
-- 41 % 1
-- >>> expectedScore [Oudler, Oudler, Oudler]
-- 36 % 1
expectedScore :: [Tarot] -> Rational
expectedScore tarots =
  case oudlerCount of
    0 -> 56
    1 -> 51
    2 -> 41
    3 -> 36
    _ -> error "invalid number of oudlers"
  where
    oudlerCount = length $ filter (== Oudler) tarots

-- |
-- >>> tarotScore ""
-- (-56) % 1
-- >>> tarotScore "0002"
-- (-46) % 1
-- >>> tarotScore "HK02"
-- (-51) % 1
-- >>> tarotScore "HK02HK" -- 50.5
-- (-103) % 2
-- >>> tarotScore "HK0202" -- 51.5
-- (-101) % 2
-- >>> tarotScore "HQ02"
-- (-52) % 1
-- >>> tarotScore "HC02"
-- (-53) % 1
-- >>> tarotScore "HJ02"
-- (-54) % 1
-- >>> tarotScore "0202"
-- (-55) % 1
-- >>> tarotScore "00010203040506070809101112131415161718192021S1S2S3S4S5S6S7S8S9S0SJSCSQSKH1H2H3H4H5H6H7H8H9H0HJHCHQHKD1D2D3D4D5D6D7D8D9D0DJDCDQDKC1C2C3C4C5C6C7C8C9C0CJCCCQCK"
-- 55 % 1
-- >> tarotScore "SC15DQ0904D7D41703H3CQ0607H6051612HKH7H2SKHCHQ20D3C9CJS7D5DCS5D6C8H9S41014C7S0SQC4S2H419H001D1C3D0S3D9CKC1DJCCS821S90213C0C5S618S1D8H5H8HJ08C6DKSJ11H100C2D2"
-- (-99) % 2
-- >> tarotScore "15HCDKHQD6D5D7S5SK08S9D1S4DJH0CJCKC5CQ18S7C3S6HJH7C207D81910S001C41312H116C9D3D2S2H5H800CC170921S102H3H4HKD9H204S8S3SJ05C6D4C7D0DQ20DC1106H914SQC1C8C0H603SC"
-- (-97) % 2
tarotScore :: String -> Rational
tarotScore s = score + oddScore - expectedScore tarots
  where

    oddCards = (odd . length) tarots

    tarots = parseTarot s
    (ordinaries, counters) = balanceRight $ partition (==Ordinary) $ sort $ tarots
    scorePair _ Oudler = 5
    scorePair _ King = 5
    scorePair _ Queen = 4
    scorePair _ Knight = 3
    scorePair _ Jack = 2
    scorePair _ _ = 1
    score = toEnum $ sum $ zipWith scorePair ordinaries counters
    oddScore =
      1 % 2 *
      case compare (length ordinaries) (length counters) of
        EQ -> 0
        GT -> 1
        LT -> -1
