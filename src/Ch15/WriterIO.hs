{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}


module Ch15.WriterIO
  ( WriterIO(..)
  , runWriterIO
  ) where

import System.IO (IOMode(..))
import Control.Monad.Writer
import Ch15.SafeHello
import Ch15.MonadHandle

data Event
  = Open FilePath IOMode
  | Put String String
  | Close String
  | GetContents String
  deriving (Show)

newtype WriterIO a =
  W
    { runW :: Writer [Event] a
    } deriving (Functor, Applicative, Monad, MonadWriter [Event])

runWriterIO :: WriterIO a -> (a, [Event])
runWriterIO = runWriter . runW

instance MonadHandle FilePath WriterIO where
  openFile path mode = tell [Open path mode] >> return path
  hPutStr h str = tell [Put h str]
  hClose h = tell [Close h]
  hGetContents h = tell [GetContents h] >> return ""
