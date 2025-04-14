{-# LANGUAGE ForeignFunctionInterface #-}

-- | Low-level FFI bindings for isl_ctx.
-- This module is intended for internal use by the safe wrapper module.
module Foreign.Isl.Ctx
  ( IslCtx(..) -- Export constructor for wrapping/unwrapping
  , islCtxAlloc
  , islCtxFree
  ) where

import Foreign.Ptr (Ptr)

#include <isl/ctx.h>

-- | A newtype wrapper around the raw pointer to an isl_ctx.
newtype IslCtx = IslCtx (Ptr IslCtx)

-- | Allocate a new isl_ctx. Unsafe, requires manual freeing.
foreign import ccall unsafe "isl_ctx_alloc"
  islCtxAlloc :: IO IslCtx

-- | Free an allocated isl_ctx. Unsafe.
foreign import ccall unsafe "isl_ctx_free"
  islCtxFree :: IslCtx -> IO ()
