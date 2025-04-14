{-# LANGUAGE ForeignFunctionInterface #-}

module Foreign.Isl.Ctx
  ( IslCtx(..)
  , islCtxAlloc
  , islCtxFree
  ) where

import Foreign.Ptr (Ptr)

#include <isl/ctx.h>

newtype IslCtx = IslCtx (Ptr IslCtx)

foreign import ccall unsafe "isl_ctx_alloc"
  islCtxAlloc :: IO IslCtx

foreign import ccall unsafe "isl_ctx_free"
  islCtxFree :: IslCtx -> IO ()
