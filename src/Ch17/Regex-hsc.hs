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
  deriving (Eq, Show)

