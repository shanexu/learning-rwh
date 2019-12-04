import           Data.Char (digitToInt)

loop :: Int -> String -> Int
loop acc (x:xs) =
  let acc' = acc * 10 + digitToInt x
   in loop acc' xs
loop acc [] = acc

asInt xs = loop 0 xs
