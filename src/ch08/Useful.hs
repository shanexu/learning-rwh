import           Glob             (namesMatching)
import           System.Directory (doesFileExist, renameDirectory, renameFile)
import           System.FilePath  (replaceExtension)

renameWith :: (FilePath -> FilePath) -> FilePath -> IO FilePath
renameWith f path = do
  let path' = f path
  rename path path'
  return path'

rename :: FilePath -> FilePath -> IO ()
rename old new = do
  isFile <- doesFileExist old
  let f =
        if isFile
          then renameFile
          else renameDirectory
  f old new

cc2cpp =
  mapM (renameWith (`replaceExtension` ".cpp")) =<< namesMatching "*.cc"