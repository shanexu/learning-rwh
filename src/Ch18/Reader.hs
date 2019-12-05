{-# LANGUAGE FunctionalDependencies #-}

module Ch18.Reader where

class (Monad m) => MonadReader r m | m -> r where
  ask :: m r
  local :: (r -> r) -> m a -> m a

