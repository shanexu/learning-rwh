module Ch15.AltSupply
  (
  ) where

import Ch15.Supply
import Control.Monad.State

unwrapS :: Supply s a -> State [s] a
unwrapS (S s) = s

instance Functor (Supply s) where
  fmap f = S . fmap f . unwrapS

instance Applicative (Supply s) where
  pure = S . return
  f <*> a = S (unwrapS f <*> unwrapS a)

instance Monad (Supply s) where
  s >>= m = S (unwrapS s >>= unwrapS . m)
