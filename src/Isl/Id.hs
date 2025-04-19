module Isl.Id
  ( IslId(..)
  , allocId
  ) where

import qualified Foreign.Isl.Id as RawId
import qualified Foreign.Isl.Ctx as RawCtx
import qualified Isl.Ctx as Ctx
import Foreign.Ptr (nullPtr, Ptr)
import Foreign.C.String (withCString)
import System.IO.Unsafe (unsafePerformIO)

newtype IslId = Wrap RawId.IslId

allocIdIo :: Ctx.IslCtx -> String -> Ptr () -> IO (Maybe IslId)
allocIdIo (Ctx.Wrap (RawCtx.IslCtx rawCtxPtr)) str ptr = do
  rawIdPtr <- withCString str $ \cStr -> 
    RawId.islIdAlloc rawCtxPtr cStr ptr
  if rawIdPtr == nullPtr
    then return Nothing
    else return (Just (Wrap (RawId.IslId rawIdPtr)))

allocId :: Ctx.IslCtx -> String -> Ptr () -> Maybe IslId
allocId ctx str ptr = unsafePerformIO (allocIdIo ctx str ptr)
{-# NOINLINE allocId #-}
