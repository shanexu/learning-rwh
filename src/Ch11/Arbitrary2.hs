module Arbitrary2
  ()
  where

instance Arbitrary Ternary where
  arbitrary     = do
    n <- choose (0, 2) :: Gen Int
    return $ case n of
      0 -> Yes
      1 -> No
      _ -> Unknown


