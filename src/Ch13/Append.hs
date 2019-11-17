import Prelude(undefined)

main = undefined

(++) :: [a] -> [a] -> [a]
(x:xs) ++ ys = x : xs ++ ys
_ ++ ys = ys
