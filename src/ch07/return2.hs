import Data.Char(toUpper)

isYes :: String -> Bool
isYes =  (== 'Y') .  toUpper . head