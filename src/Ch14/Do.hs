module Ch14.Do
  (
  ) where

robust :: [a] -> Maybe a
robust xs = do (_:x:_) <- Just xs
               return x
