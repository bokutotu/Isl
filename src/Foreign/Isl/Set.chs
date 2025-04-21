{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Set
  ( IslSet(..)
  , islSetReadFromStr
  ) where

import Foreign.C.String (CString)

{#context lib="isl"#}
{#import  Foreign.Isl.Ctx #}

#include <isl/set.h>

{#pointer *isl_set as IslSet  foreign newtype#}

{#fun isl_set_read_from_str as islSetReadFromStr { `IslCtx', `CString' } -> `IslSet' #}

