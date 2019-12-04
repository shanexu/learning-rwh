import Text.ParserCombinators.Parsec

main :: IO ()
main = undefined

csvFile = endBy line eol
line = sepBy cell (char ',')
cell = many (noneOf  ",\n")
eol = char '\n'

parseCSV :: String -> Either ParseError [[String]]
parseCSV = parse csvFile "(unknown)" 
