module Ch15.MonadPlus
  (
  ) where

import Control.Monad(mzero, MonadPlus)

guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()
guard False = mzero

x `zeroMod` n = guard ((x `mod` n) == 0) >> return x
