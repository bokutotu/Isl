{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Map
  ( IslMap
  , IslMapPtr
  , islMapReadFromStr
  , islMapReverse
  ) where

import Foreign.Ptr
import Foreign.C.String
import Foreign.C.Types
import Foreign.Isl.Ctx

#include <isl/map.h>

-- | The ISL map structure
data IslMap

-- | Opaque type for isl_map
type IslMapPtr = Ptr IslMap

-- | Read a map from a string
foreign import capi "isl/map.h isl_map_read_from_str" c_isl_map_read_from_str
  :: IslCtxPtr -> CString -> IO IslMapPtr

-- | Reverse a map
foreign import capi "isl/map.h isl_map_reverse" c_isl_map_reverse
  :: IslMapPtr -> IO IslMapPtr

-- Haskell wrappers
islMapReadFromStr :: IslCtxPtr -> String -> IO IslMapPtr
islMapReadFromStr ctx str = withCString str $ \cstr ->
  c_isl_map_read_from_str ctx cstr

islMapReverse :: IslMapPtr -> IO IslMapPtr
islMapReverse = c_isl_map_reverse 