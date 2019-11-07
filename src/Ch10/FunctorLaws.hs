import Prelude(undefined, Int, Either(..))

main = undefined

class Functor f where
  fmap :: (a -> b) -> f a -> f b

fmap id == id
fmap (f .g) == fmap f . fmap g
