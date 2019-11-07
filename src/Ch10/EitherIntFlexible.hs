{-# LANGUAGE FlexibleInstances #-}

import Prelude(undefined, Int, Either(..))

main = undefined

class Functor f where
  fmap :: (a -> b) -> f a -> f b

instance Functor (Either Int) where
  fmap _ (Left n) = Left n
  fmap f (Right r) = Right (f r)
