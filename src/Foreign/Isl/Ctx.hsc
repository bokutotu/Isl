{-# LANGUAGE ForeignFunctionInterface #-}

module Foreign.Isl.Ctx where

import Foreign.Ptr (Ptr)

-- Include the necessary ISL header for context definitions
#include <isl/ctx.h>

-- | A newtype wrapper for the opaque isl_ctx pointer.
newtype IslCtx = IslCtx (Ptr IslCtx)

-- | Allocate a new isl context.
-- Corresponds to C function: isl_ctx *isl_ctx_alloc(void);
foreign import ccall unsafe "isl_ctx_alloc"
  islCtxAlloc :: IO IslCtx

-- | Free an isl context.
-- Corresponds to C function: void isl_ctx_free(isl_ctx *ctx);
foreign import ccall unsafe "isl_ctx_free"
  islCtxFree :: IslCtx -> IO ()

-- Add other context-related functions here as needed.
