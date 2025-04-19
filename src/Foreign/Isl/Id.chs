{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Id
  ( IslId(..)
  , islIdAlloc
  , islIdFree
  ) where

import Foreign.C.String (CString)
import Foreign.Ptr      (Ptr)

{#context lib="isl"#}
#include <isl/id.h>
#include <isl/ctx.h>

{#pointer *isl_ctx as IslCtx foreign newtype#}

{#pointer *isl_id  as IslId  foreign newtype#}

{#fun isl_id_alloc as islIdAlloc
    { `IslCtx'
    , `CString'
    , `Ptr ()'
    }
    -> `IslId'
#}

{#fun isl_id_free  as islIdFree
    { `IslId' }
    -> `()'
#}

