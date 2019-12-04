import           Prelude (id, otherwise, seq)

foldl :: (a -> b -> a) -> a -> [b] -> a
foldl step zero (x:xs) = foldl step (step zero x) xs
foldl _ zero []        = zero

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr step zero (x:xs) = step x (foldr step zero xs)
foldr _ zero []        = zero

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f z xs = foldr step id xs z
  where
    step x g = \a -> g (f a x)

myMap f xs = foldr step [] xs
  where
    step x ys = f x : ys

myFilter p xs = foldr step [] xs
  where
    step x ys
      | p x = x : ys
      | otherwise = ys

foldl' :: (a -> b -> a) -> a -> [b] -> a
foldl' _ zero [] = zero
foldl' step zero (x:xs) =
  let new = step zero x
   in new `seq` foldl' step new xs

strictPair (a, b) = a `seq` b `seq` (a, b)