{-# LANGUAGE ScopedTypeVariables #-}

import           Control.Exception (SomeException, bracket, handle)
import           Control.Monad     (forM, liftM, mapM, return)
import           Data.Time         (UTCTime (..))
import           Prelude           (Bool (..), Eq (..), IO, Integer, Maybe (..),
                                    Ord, Show, String, concat, filter, map,
                                    maybe, notElem, undefined, ($), (&&), (.))
import           System.Directory  (Permissions (..), getDirectoryContents,
                                    getModificationTime, getPermissions,
                                    searchable)
import           System.FilePath   (FilePath, (</>))
import           System.IO         (IOMode (..), hClose, hFileSize, openFile,
                                    withFile)

data Info =
  Info
    { infoPath    :: FilePath
    , infoPerms   :: Maybe Permissions
    , infoSize    :: Maybe Integer
    , infoModTime :: Maybe UTCTime
    }
  deriving (Eq, Ord, Show)

maybeIO :: IO a -> IO (Maybe a)
maybeIO act = handle (\(_ :: SomeException) -> return Nothing) (Just `liftM` act)

getInfo :: FilePath -> IO Info
getInfo path = do
  perms <- maybeIO (getPermissions path)
  size <- maybeIO (withFile path ReadMode hFileSize)
  modified <- maybeIO (getModificationTime path)
  return (Info path perms size modified)

traverse :: ([Info] -> [Info]) -> FilePath -> IO [Info]
traverse order path = do
  names <- getUsefulContents path
  contents <- mapM getInfo (path : map (path </>) names)
  liftM concat $
    forM (order contents) $ \info ->
      if isDirectory info && infoPath info /= path
        then traverse order (infoPath info)
        else return [info]

getUsefulContents :: FilePath -> IO [String]
getUsefulContents path = do
  names <- getDirectoryContents path
  return (filter (`notElem` [".", ".."]) names)

isDirectory :: Info -> Bool
isDirectory = maybe False searchable . infoPerms

traverseVerbose order path = do
  names <- getDirectoryContents path
  let usefulNames = filter (`notElem` [".", ".."]) names
  contents <- mapM getEntryName ("" : usefulNames)
  recursiveContents <- mapM recurse (order contents)
  return (concat recursiveContents)
  where
    getEntryName name = getInfo (path </> name)
    isDirectory info =
      case infoPerms info of
        Nothing    -> False
        Just perms -> searchable perms
    recurse info =
      if isDirectory info && infoPath info /= path
        then traverseVerbose order (infoPath info) 
        else return [info]
