module Ch19.ParseInt where

import Control.Monad.Except
import Control.Monad.State
import qualified Data.ByteString.Char8 as B

data ParseError
  = NumericOverflow
  | EndOfInput
  | Chatty String
  deriving (Eq, Ord, Show)

