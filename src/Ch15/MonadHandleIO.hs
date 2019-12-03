{-# LANGUAGE MultiParamTypeClasses #-}

module Ch15.MonadHandleIO
  (
  ) where

import Ch15.MonadHandle
import qualified System.IO

import System.IO (IOMode(..))
import Control.Monad.Trans (MonadIO(..), MonadTrans(..))
import System.Directory(removeFile)

import Ch15.SafeHello

instance MonadHandle System.IO.Handle IO where
  openFile = System.IO.openFile
  hPutStr = System.IO.hPutStr
  hClose = System.IO.hClose
  hGetContents = System.IO.hGetContents
  hPutStrLn = System.IO.hPutStrLn
