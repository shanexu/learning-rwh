module Ch14.SimpleState
  (
  ) where

type SimpleState s a = s -> (a, s)

type StringState a = SimpleState String a

returnSt :: a -> SimpleState s a
returnSt a = \s -> (a, s)

returnAlt :: a ->SimpleState s a
returnAlt a s = (a, s)

bindSt :: SimpleState s a -> (a -> SimpleState s b) -> SimpleState s b
bindSt m k =
  \s ->
    let (a, s') = m s
     in k a s'

bindAlt :: (s -> (a, s)) -> (a -> s -> (b, s)) -> (s -> (b, s))
bindAlt step makeStep oldState =
  let (result, newState) = step oldState
   in makeStep result newState

getSt :: SimpleState s s
getSt = \s -> (s, s)

putSt :: s -> SimpleState s ()
putSt s = \_ -> ((), s)
