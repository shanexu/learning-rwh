main = undefined

divBy :: Integral a => a -> [a] -> Maybe [a]
divBy _ [] = Just []
divBy _ (0:_) = Nothing
divBy numberator (denom:xs) =
  case divBy numberator xs of
    Nothing -> Nothing
    Just results -> Just ((numberator `div` denom) : results)
