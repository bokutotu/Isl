module Isl.Set
  ( IslSet(..)
  , readSet
  ) where

import qualified Foreign.Isl.Set as RawSet
import qualified Foreign.Isl.Ctx as RawCtx
import qualified Isl.Ctx as Ctx
import Foreign.Ptr (nullPtr)
import Foreign.C.String (withCString)
import System.IO.Unsafe (unsafePerformIO)

newtype IslSet = Wrap RawSet.IslSet

readSetIo :: Ctx.IslCtx -> String -> IO (Maybe IslSet)
readSetIo (Ctx.Wrap (RawCtx.IslCtx rawCtxPtr)) str = do
  rawSetPtr <- withCString str $ \cStr -> 
    RawSet.islSetReadFromStr rawCtxPtr cStr
  if rawSetPtr == nullPtr
    then return Nothing
    else return (Just (Wrap (RawSet.IslSet rawSetPtr)))

readSet :: Ctx.IslCtx -> String -> Maybe IslSet
readSet ctx str = unsafePerformIO (readSetIo ctx str)
{-# NOINLINE readSet #-}
