import qualified Data.ByteString.Lazy.Char8 as L

closing = readPrice . (!! 4) . L.split ','

highestClose = maximum . (Nothing :) . map closing . L.lines

readPrice :: L.ByteString -> Maybe Int
readPrice str =
  case L.readInt str of
    Nothing -> Nothing
    Just (dollars, rest) ->
      case L.readInt (L.tail rest) of
        Nothing            -> Nothing
        Just (cents, more) -> Just (dollars * 100 + cents)
