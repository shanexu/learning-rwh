main = do
  putStrLn "Greetings! What is your name?"
  inpStr <- getLine
  putStrLn $ "Welcome to Haskell, " ++ inpStr ++ "!"
--main = putStrLn "Greeting! What is your name?" >> fmap (\s -> "Welcome to Haskell, " ++ s ++ "!") getLine >>= putStrLn
