import Data.List

noAsPattern :: [a] -> [[a]]
noAsPattern (x:xs) = (x : xs) : noAsPattern xs
noAsPattern _      = []

suffixes2 xs = init (tails xs)

compose :: (b -> c) -> (a -> b) -> a -> c
compose f g x = f (g x)

suffixes3 :: [a] -> [[a]]
suffixes3 xs = compose init tails xs

suffixes4 :: [a] -> [[a]]
suffixes4 = compose init tails

suffixes5 :: [a] -> [[a]]
suffixes5 = init . tails