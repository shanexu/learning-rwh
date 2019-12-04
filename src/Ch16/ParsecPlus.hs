main = putStrLn "hello world!"

instance MonadPlus (GenParser tok st) where
  mzero = fail "mzero"
  mplus = (<|>)
