{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Ctx
  ( IslCtx(..)
  , islCtxAlloc
  , islCtxFree
  ) where

{#context lib="isl"#}

#include <isl/ctx.h>

{#pointer *isl_ctx as IslCtx foreign newtype#}

{#fun isl_ctx_alloc as islCtxAlloc { }          -> `IslCtx'#}
{#fun isl_ctx_free  as islCtxFree  { `IslCtx' } -> `()'#}

