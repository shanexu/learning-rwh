{-# LANGUAGE ScopedTypeVariables #-}

import           Control.Exception (SomeException, handle)
import           Control.Monad     (liftM)
import           Data.Char         (toLower)
import           Data.Time         (UTCTime (..))
import           System.Directory  (Permissions (..), getDirectoryContents,
                                    getModificationTime, getPermissions,
                                    searchable)
import           System.FilePath   (takeExtension, takeFileName, (</>))
import           System.IO         (IOMode (..), hClose, hFileSize, withFile)

data Info =
  Info
    { infoPath    :: FilePath
    , infoPerms   :: Maybe Permissions
    , infoSize    :: Maybe Integer
    , infoModTime :: Maybe UTCTime
    }
  deriving (Eq, Ord, Show)

getUsefulContents :: FilePath -> IO [String]
getUsefulContents path = do
  names <- getDirectoryContents path
  return (filter (`notElem` [".", ".."]) names)

getInfo :: FilePath -> IO Info
getInfo path = do
  perms <- maybeIO (getPermissions path)
  size <- maybeIO (withFile path ReadMode hFileSize)
  modified <- maybeIO (getModificationTime path)
  return (Info path perms size modified)

maybeIO :: IO a -> IO (Maybe a)
maybeIO act = handle (\(_ :: SomeException) -> return Nothing) (Just `liftM` act)

isDirectory :: Info -> Bool
isDirectory = maybe False searchable . infoPerms

data Iterate seed
  = Done
      { unwrap :: seed
      }
  | Skip
      { unwrap :: seed
      }
  | Continue
      { unwrap :: seed
      }
  deriving (Show)

type Iterator seed = seed -> Info -> Iterate seed

foldTree :: (b -> Info -> Iterate b) -> b -> FilePath -> IO b
foldTree iter initSeed path = do
  endSeed <- fold initSeed path
  return (unwrap endSeed)
  where
    fold seed subpath = getUsefulContents subpath >>= walk seed
    walk seed (name:names) = do
      let path' = path </> name
      info <- getInfo path'
      case iter seed info of
        done@(Done _) -> return done
        Skip seed' -> walk seed' names
        Continue seed'
          | isDirectory info -> do
            next <- fold seed' path'
            case next of
              done@(Done _) -> return done
              seed''        -> walk (unwrap seed'') names
          | otherwise -> walk seed' names
    walk seed _ = return (Continue seed)

atMostTreePictures :: Iterator [FilePath]
atMostTreePictures paths info
  | length paths == 3 = Done paths
  | isDirectory info && takeFileName path == ".svn" = Skip paths
  | extension `elem` [".jpg", ".png"] = Continue (path : paths)
  | otherwise = Continue paths
  where
    extension = map toLower (takeExtension path)
    path = infoPath info

countDirectories :: Num seed => Iterator seed
countDirectories count info =
  Continue
    (if isDirectory info
       then count + 1
       else count)
