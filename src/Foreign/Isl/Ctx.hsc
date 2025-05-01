{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Ctx
  ( IslCtx
  , IslCtxPtr
  , islCtxAlloc
  , islCtxFree
  , islCtxGetMaxOperations
  , islCtxSetMaxOperations
  ) where

import Foreign.Ptr
import Foreign.C.Types

#include <isl/ctx.h>

-- | The ISL context structure
data IslCtx

-- | Opaque type for isl_ctx
type IslCtxPtr = Ptr IslCtx

-- | Allocate an ISL context
foreign import capi "isl/ctx.h isl_ctx_alloc" c_isl_ctx_alloc
  :: IO IslCtxPtr

-- | Free an ISL context
foreign import capi "isl/ctx.h isl_ctx_free" c_isl_ctx_free
  :: IslCtxPtr -> IO ()

-- | Get the maximum number of operations
foreign import capi "isl/ctx.h isl_ctx_get_max_operations" c_isl_ctx_get_max_operations
  :: IslCtxPtr -> IO CULong

-- | Set the maximum number of operations
foreign import capi "isl/ctx.h isl_ctx_set_max_operations" c_isl_ctx_set_max_operations
  :: IslCtxPtr -> CULong -> IO ()

-- Haskell wrappers
islCtxAlloc :: IO IslCtxPtr
islCtxAlloc = c_isl_ctx_alloc

islCtxFree :: IslCtxPtr -> IO ()
islCtxFree = c_isl_ctx_free

islCtxGetMaxOperations :: IslCtxPtr -> IO CULong
islCtxGetMaxOperations = c_isl_ctx_get_max_operations

islCtxSetMaxOperations :: IslCtxPtr -> CULong -> IO ()
islCtxSetMaxOperations = c_isl_ctx_set_max_operations 