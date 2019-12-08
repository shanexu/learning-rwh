import Control.Exception

main = undefined

handler :: ArithException -> IO ()
handler e = putStrLn $ "Caught arithmetic error: " ++ show e

catchIt :: ArithException -> Maybe ArithException
catchIt = Just

safePrint :: Integer -> IO ()
safePrint x = handleJust catchIt handler (print x)
