{-# LANGUAGE ForeignFunctionInterface #-}
module Foreign.Isl.Val 
  (  IslVal(..)
   , islValZero
   , islValOne
   , islValNegOne
   , islValNan
   , islValInfty
   , islValNegInfty
   , islValIntFromSi
   , islValIntFromUi
   , islValIsInt
   , islValIsZero
   , islValIsOne
   , islValIsNegOne
   , islValIsNan
   , islValIsInfty
   , islValIsNegInfty
   , islValFree
  ) where

import Foreign.C.Types (CLong, CULong)

{#context lib="isl"#}
{#import  Foreign.Isl.Ctx #}

#include <isl/val.h>

{#pointer *isl_val as IslVal foreign newtype#}

{#fun isl_val_zero as islValZero { `IslCtx' } -> `IslVal'#}
{#fun isl_val_one as islValOne { `IslCtx' } -> `IslVal'#}
{#fun isl_val_negone as islValNegOne { `IslCtx' } -> `IslVal'#}
{#fun isl_val_nan as islValNan { `IslCtx' } -> `IslVal'#}
{#fun isl_val_infty as islValInfty { `IslCtx' } -> `IslVal'#}
{#fun isl_val_neginfty as islValNegInfty { `IslCtx' } -> `IslVal'#}
{#fun isl_val_int_from_si as islValIntFromSi { `IslCtx', `CLong' } -> `IslVal'#}
{#fun isl_val_int_from_ui as islValIntFromUi { `IslCtx', `CULong' } -> `IslVal'#}
{#fun isl_val_is_int as islValIsInt { `IslVal' } -> `Bool'#}
{#fun isl_val_is_zero as islValIsZero { `IslVal' } -> `Bool'#}
{#fun isl_val_is_one as islValIsOne { `IslVal' } -> `Bool'#}
{#fun isl_val_is_negone as islValIsNegOne { `IslVal' } -> `Bool'#}
{#fun isl_val_is_nan as islValIsNan { `IslVal' } -> `Bool'#}
{#fun isl_val_is_infty as islValIsInfty { `IslVal' } -> `Bool'#}
{#fun isl_val_is_neginfty as islValIsNegInfty { `IslVal' } -> `Bool'#}
{#fun isl_val_free as islValFree { `IslVal' } -> `()'#}
