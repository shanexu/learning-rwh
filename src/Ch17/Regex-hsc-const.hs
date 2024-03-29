{-# LANGUAGE CPP #-}
{-# LANGUAGE ForeignFunctionInterface #-}

module Ch17.Regex where

import Foreign
import Foreign.C.Types

#include <pcre.h>

newtype PCREOption =
  PCREOption
    { unPCREOption :: CInt
    }
  deriving (Eq, Ord, Show, Read)

caseless :: PCREOption
caseless = PCREOption #const PCRE_CASELESS

dollar_endonly :: PCREOption
dollar_endonly = PCREOption #const PCRE_DOLLAR_ENDONLY

dotall :: PCREOption
dotall = PCREOption #const PCRE_DOTALL
