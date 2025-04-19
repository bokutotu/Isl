{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Set
  ( IslSet(..)
  , islSetReadFromStr
  ) where

import Foreign.C.String (CString)

{#context lib="isl"#}
#include <isl/set.h>
#include <isl/ctx.h>

{#pointer *isl_ctx as IslCtx  foreign newtype#}
{#pointer *isl_set as IslSet  foreign newtype#}

{#fun isl_set_read_from_str as islSetReadFromStr
    { `IslCtx'
    , `CString'
    }
    -> `IslSet'
#}

