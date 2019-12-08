import Control.Exception

main = undefined

catchIt :: ArithException -> Maybe ()
catchIt DivideByZero = Just ()
catchIt _ = Nothing

handler :: () -> IO ()
handler _ = putStrLn "Caught error: divide by zero"

safePrint :: Integer -> IO ()
safePrint x = handleJust catchIt handler (print x)
