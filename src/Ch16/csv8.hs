import Text.ParserCombinators.Parsec

main = undefined

csvFile = endBy line eol
line = sepBy cell (char ',')
cell = many (noneOf ",\n\r")

eol =
  try (string "\n\r") <|> try (string "\r\n") <|> string "\n" <|> string "\r" <?> "end of line"

parseCSV :: String -> Either ParseError [[String]]
parseCSV = parse csvFile "(unknown)"
