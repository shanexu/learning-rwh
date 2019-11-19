module Ch14.Logger
  ( Logger
  , Log
  , runLogger
  , record
  ) where

newtype Logger a = Logger { execLogger :: (a, Log)}
type Log = [String]

runLogger :: Logger a -> (a, Log)
runLogger = execLogger

record :: String -> Logger ()
record s = Logger ((), [s])

instance Functor Logger where
  fmap f a =
    let (r, s) = execLogger a
     in Logger (f r, s)

instance Applicative Logger where
  pure a = Logger (a, [])
  f <*> a =
    let (a', s1) = runLogger a
        (f', s2) = runLogger f
     in Logger (f' a', s1 ++ s2)

instance Monad Logger where
  m >>= k =
    let (a, w) = execLogger m
        n = k a
        (b, x) = execLogger n
     in Logger (b, w ++ x)


globToRegex :: String -> Logger String
globToRegex cs = globToRegex' cs >>= \ds -> return ('^' : ds)
globToRegex' :: String -> Logger String
globToRegex' "" = return "$"
globToRegex' ('?':cs) =
  record "any" >> globToRegex' cs >>= \ds -> return ('.' : ds)
globToRegex' ('*':cs) = do
  record "kleene star"
  ds <- globToRegex' cs
  return (".*" ++ ds)
globToRegex' ('[':'!':c:cs) =
  record "character class, negative" >> charClass cs >>= \ds ->
    return ("[^" ++ c : ds)
globToRegex' ('[':c:cs) =
  record "character class" >> charClass cs >>= \ds -> return ('[' : c : cs)
globToRegex' ('[':_) = fail "unterminated character class"

charClassWordy (']':cs) = globToRegex' cs >>= \ds -> return (']' : ds)
charClassWordy (c:cs) = charClassWordy cs >>= \ds -> return (c : ds)

charClass (']':cs) = (']':) `liftM` globToRegex' cs
charClass (c:cs) = (c :) `liftM` charClass cs

liftM :: (Monad m) => (a -> b) -> m a -> m b
liftM f m = m >>= \i -> return (f i)

liftM2 :: (Monad m) => (a -> b -> c) -> m a -> m b -> m c
liftM2 f m1 m2 = m1 >>= \a -> m2 >>= \b -> return (f a b)
