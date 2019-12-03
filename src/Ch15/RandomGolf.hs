module Ch15.RandomGolf
  (
  ) where

import Control.Arrow (first)
import System.Random

randomIO_golfed :: Random a => IO [a]
randomIO_golfed = getStdRandom (first randoms . split)
