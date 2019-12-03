{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Ch15.SupplyInstance
  ( MySupply(..)
  , xy
  , xy'
  , runMS
  ) where

import Ch15.SupplyClass
import Control.Monad.Fail (MonadFail)

newtype Reader e a =
  R
    { runReader :: e -> a
    }

instance Functor (Reader e) where
  fmap f r = R $ f . runReader r

instance Applicative (Reader e) where
  pure = R . const
  f <*> a = R $ \e -> runReader f e (runReader a e)

instance Monad (Reader e) where
  return = R . const
  m >>= k = R $ \r -> runReader (k (runReader m r)) r

ask :: Reader e e
ask = R id

newtype MySupply e a =
  MySupply
    { runMySupply :: Reader e a
    }
  deriving (Functor, Applicative, Monad)

instance MonadSupply e (MySupply e) where
  next = MySupply (Just <$> ask)

xy :: (Num s, MonadSupply s m, MonadFail m) => m s
xy = do
  Just x <- next
  Just y <- next
  return (x * y)

xy' :: (Num s, MonadSupply s m) => m s
xy' = do
  x <- next
  y <- next
  case (x, y) of
    (Just x', Just y') -> return (x' * y')
    _ -> return 0

runMS :: MySupply i a -> i -> a
runMS = runReader . runMySupply
