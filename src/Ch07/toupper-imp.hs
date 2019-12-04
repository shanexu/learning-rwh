import           Data.Char (toUpper)
import           System.IO

main :: IO ()
main = do
  inh <- openFile "input.txt" ReadMode
  outh <- openFile "output.txt" WriteMode
  mainloop inh outh
  hClose inh
  hClose outh
  where
    mainloop inh outh = do
      ineof <- hIsEOF inh
      if ineof
        then return ()
        else do
          inpStr <- hGetLine inh
          hPutStrLn outh (map toUpper inpStr)
          mainloop inh outh
