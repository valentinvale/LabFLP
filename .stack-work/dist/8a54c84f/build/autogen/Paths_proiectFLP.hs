{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_proiectFLP (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "C:\\Users\\valus\\Desktop\\Uni\\Anul 2\\Semestrul 2\\FLP\\Laborator\\proiect\\LabFLP\\.stack-work\\install\\7d9978a0\\bin"
libdir     = "C:\\Users\\valus\\Desktop\\Uni\\Anul 2\\Semestrul 2\\FLP\\Laborator\\proiect\\LabFLP\\.stack-work\\install\\7d9978a0\\lib\\x86_64-windows-ghc-9.2.7\\proiectFLP-0.1.0.0-J5dv7EAN86E2NjCnid24mg"
dynlibdir  = "C:\\Users\\valus\\Desktop\\Uni\\Anul 2\\Semestrul 2\\FLP\\Laborator\\proiect\\LabFLP\\.stack-work\\install\\7d9978a0\\lib\\x86_64-windows-ghc-9.2.7"
datadir    = "C:\\Users\\valus\\Desktop\\Uni\\Anul 2\\Semestrul 2\\FLP\\Laborator\\proiect\\LabFLP\\.stack-work\\install\\7d9978a0\\share\\x86_64-windows-ghc-9.2.7\\proiectFLP-0.1.0.0"
libexecdir = "C:\\Users\\valus\\Desktop\\Uni\\Anul 2\\Semestrul 2\\FLP\\Laborator\\proiect\\LabFLP\\.stack-work\\install\\7d9978a0\\libexec\\x86_64-windows-ghc-9.2.7\\proiectFLP-0.1.0.0"
sysconfdir = "C:\\Users\\valus\\Desktop\\Uni\\Anul 2\\Semestrul 2\\FLP\\Laborator\\proiect\\LabFLP\\.stack-work\\install\\7d9978a0\\etc"

getBinDir     = catchIO (getEnv "proiectFLP_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "proiectFLP_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "proiectFLP_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "proiectFLP_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "proiectFLP_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "proiectFLP_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '\\'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/' || c == '\\'
