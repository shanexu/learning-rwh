main = undefined

divBy :: Integral a => a -> [a] -> Maybe [a]
divBy _ [] = return []
divBy _ (0:_) = fail "division by zero in divBy"
divBy numberator (denom:xs) = do
  next <- divBy numberator xs
  return ((numberator `div` denom) : next)
