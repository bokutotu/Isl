{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Ctx
  ( IslCtx(..)
  , withIslCtx
  , islCtxAlloc
  , islCtxFree
  , islCtxResetError
  , islCtxLastErrorMsg
  ) where

import Foreign.C.String (CString)

{#context lib="isl"#}

#include <isl/ctx.h>

{#pointer *isl_ctx as IslCtx foreign newtype#}

{#fun isl_ctx_alloc as islCtxAlloc { } -> `IslCtx'#}
{#fun isl_ctx_free  as islCtxFree  { `IslCtx' } -> `()'#}
{#fun isl_ctx_reset_error as islCtxResetError { `IslCtx' } -> `()'#}
{#fun isl_ctx_last_error_msg as islCtxLastErrorMsg { `IslCtx' } -> `CString'#}

