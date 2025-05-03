{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Set
  ( IslSet
  , IslSetPtr
  , islSetReadFromStr
  , islSetCoalesce
  , islSetSamplePoint
  ) where

import Foreign.Ptr
import Foreign.C.String
import Foreign.Isl.Ctx

#include <isl/set.h>

-- | The ISL set structure
data IslSet

-- | Opaque type for isl_set
type IslSetPtr = Ptr IslSet

-- | Read a set from a string
foreign import capi "isl/set.h isl_set_read_from_str" c_isl_set_read_from_str
  :: IslCtxPtr -> CString -> IO IslSetPtr

-- | Coalesce a set
foreign import capi "isl/set.h isl_set_coalesce" c_isl_set_coalesce
  :: IslSetPtr -> IO IslSetPtr

-- | Get a sample point from a set
foreign import capi "isl/set.h isl_set_sample_point" c_isl_set_sample_point
  :: IslSetPtr -> IO IslSetPtr

-- Haskell wrappers
islSetReadFromStr :: IslCtxPtr -> String -> IO IslSetPtr
islSetReadFromStr ctx str = withCString str $ \cstr ->
  c_isl_set_read_from_str ctx cstr

islSetCoalesce :: IslSetPtr -> IO IslSetPtr
islSetCoalesce = c_isl_set_coalesce

islSetSamplePoint :: IslSetPtr -> IO IslSetPtr
islSetSamplePoint = c_isl_set_sample_point 
