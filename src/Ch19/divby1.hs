main = undefined

divBy :: Integral a => a -> [a] -> [a]
divBy numberator = map (numberator `div`)
