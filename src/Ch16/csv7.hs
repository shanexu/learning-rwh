import Text.ParserCombinators.Parsec

main = undefined

csvFile = endBy line eol
line = sepBy cell (char ',')
cell = many (noneOf ",\n\r")

eol =
  try (string "\n\r") <|> try (string "\r\n") <|> string "\n" <|> string "\r" <|> fail "Couldn't find EOL"

parseCSV :: String -> Either ParseError [[String]]
parseCSV = parse csvFile "(unknown)"
