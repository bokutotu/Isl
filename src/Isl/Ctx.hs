module Isl.Ctx
  ( IslCtx(..)
  , initIslCtx
  ) where

import qualified Foreign.Isl.Ctx as Raw
import Foreign.Ptr (nullPtr)
import System.IO.Unsafe (unsafePerformIO)

newtype IslCtx = Wrap Raw.IslCtx

initIslCtxIO :: IO (Maybe IslCtx)
initIslCtxIO = do
  rawCtx@(Raw.IslCtx rawPtr) <- Raw.islCtxAlloc
  if rawPtr == nullPtr
    then return Nothing
    else return (Just (Wrap rawCtx))

initIslCtx :: Maybe IslCtx
initIslCtx = unsafePerformIO initIslCtxIO
{-# NOINLINE initIslCtx #-}
