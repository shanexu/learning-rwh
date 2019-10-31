import           Data.Char (toUpper)

main = do
  inpStr <- readFile "input.txt"
  writeFile "outputFile" (map toUpper inpStr)
