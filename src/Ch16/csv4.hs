import Text.ParserCombinators.Parsec

main = undefined

eol :: GenParser Char st String
eol = string "\n\r" <|> string "\n"
