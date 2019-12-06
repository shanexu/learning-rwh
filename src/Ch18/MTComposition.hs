{-# LANGUAGE FlexibleContexts #-}

module Ch18.MTComposition
  (
  ) where

import Control.Monad.Writer
import Ch18.MaybeT

problem :: MonadWriter [String] m => m ()
problem = do
  tell ["this is where i fail"]
  fail "oops"

type A = WriterT [String] Maybe

type B = MaybeT (Writer [String])

a :: A ()
a = problem

b :: B ()
b = problem

