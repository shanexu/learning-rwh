main = undefined

divBy :: Integral a => a -> [a] -> Maybe [a]
divBy = divByGeneric

divByGeneric :: (Monad m, Integral a) => a -> [a] -> m [a]
divByGeneric _ [] = return []
divByGeneric _ (0:_) = fail "division by zero in divByGeneric"
divByGeneric numberator (denom:xs) = do
  next <- divByGeneric numberator xs
  return ((numberator `div` denom) : next)
