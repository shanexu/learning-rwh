import Test.QuickCheck
import Data.List

main = undefined

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort lhs ++ [x] ++ qsort rhs
  where
    lhs = filter (< x) xs
    rhs = filter (>= x) xs

prop_idempotent xs = qsort (qsort xs) == qsort xs

-- import Test.QuickCheck.Gen
-- import Test.QuickCheck.Arbitrary
-- import Test.QuickCheck.Random
-- unGen arbitrary (mkQCGen 2) 10 :: [Bool]
