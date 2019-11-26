{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Ch15.Supply
  ( Supply(..)
  , next
  , runSupply
  ) where

import Control.Monad.State

newtype Supply s a =
  S (State [s] a)
  deriving (Functor, Applicative, Monad)

runSupply :: Supply s a -> [s] -> (a, [s])
runSupply (S m) = runState m

next :: Supply s (Maybe s)
next =
  S $ do
    st <- get
    case st of
      [] -> return Nothing
      (x:xs) -> do
        put xs
        return (Just x)
