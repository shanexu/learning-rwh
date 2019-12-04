import Text.ParserCombinators.Parsec

main = undefined

eol :: GenParser Char st Char
eol = do
  char '\n'
  char '\r' <|> return '\n'
