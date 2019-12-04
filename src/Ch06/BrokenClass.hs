{-# LANGUAGE FlexibleInstances #-}

type JSONError = String

newtype JAry a =
  JAry
    { fromJAry :: [a]
    }
  deriving (Eq, Ord, Show)

newtype JObj a =
  JObj
    { fromJObj :: [(String, a)]
    }
  deriving (Eq, Ord, Show)

data JValue
  = JString String
  | JNumber Double
  | JBool Bool
  | JNull
  | JObject (JObj JValue) -- was [(String, JValue)]
  | JArray (JAry JValue) -- was [JValue]
  deriving (Eq, Ord, Show)

class JSON a where
  toJValue :: a -> JValue
  fromJValue :: JValue -> Either JSONError a

instance (JSON a) => JSON [(String, a)] where
  toJValue = undefined
  fromJValue = undefined
