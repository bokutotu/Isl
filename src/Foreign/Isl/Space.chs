{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Space
  ( IslSpace(..)
  , islSpaceAlloc
  , islSpaceFree
  ) where

import Foreign.C.Types (CUInt)

{#context lib="isl" #}
{#import  Foreign.Isl.Ctx #}

#include <isl/space.h>

{#pointer *isl_space as IslSpace foreign newtype#}

{#fun isl_space_alloc as islSpaceAlloc { `IslCtx', `CUInt', `CUInt', `CUInt' } -> `IslSpace'#}
{#fun isl_space_free as islSpaceFree { `IslSpace' } -> `()'#}
