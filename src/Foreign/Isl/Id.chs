{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Id
  ( IslId(..)
  , islIdAlloc
  , islIdFree
  , islIdGetName
  ) where

import Foreign.C.String (CString)
import Foreign.Ptr (Ptr)

{#context lib="isl" #}
{#import  Foreign.Isl.Ctx #}

#include <isl/id.h>

{#pointer *isl_id as IslId foreign newtype #}

{#fun isl_id_alloc as islIdAlloc { `IslCtx', `CString', `Ptr ()' } -> `IslId' #}
{#fun isl_id_free  as islIdFree { `IslId' } -> `()' #}
{#fun isl_id_get_name as islIdGetName { `IslId' } -> `CString' #}

