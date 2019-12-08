main = undefined

divBy :: Integral a => a -> [a] -> [Maybe a]
divBy numberator = map worker
  where
    worker 0 = Nothing
    worker x = Just (numberator `div` x)
