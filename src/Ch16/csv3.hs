import Text.ParserCombinators.Parsec

main = undefined

eol :: GenParser Char st String
eol = string "\n" <|> string "\n\r"
