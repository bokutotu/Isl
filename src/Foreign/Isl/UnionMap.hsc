{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.UnionMap
  ( IslUnionMap
  , IslUnionMapPtr
  , islUnionMapReadFromStr
  , islUnionMapApplyRange
  , islUnionMapReverse
  , islUnionMapLexLtUnionMap
  ) where

import Foreign.Ptr
import Foreign.C.String
import Foreign.C.Types
import Foreign.Isl.Ctx

#include <isl/union_map.h>

-- | The ISL union map structure
data IslUnionMap

-- | Opaque type for isl_union_map
type IslUnionMapPtr = Ptr IslUnionMap

-- | Read a union map from a string
foreign import capi "isl/union_map.h isl_union_map_read_from_str" c_isl_union_map_read_from_str
  :: IslCtxPtr -> CString -> IO IslUnionMapPtr

-- | Apply range
foreign import capi "isl/union_map.h isl_union_map_apply_range" c_isl_union_map_apply_range
  :: IslUnionMapPtr -> IslUnionMapPtr -> IO IslUnionMapPtr

-- | Reverse a union map
foreign import capi "isl/union_map.h isl_union_map_reverse" c_isl_union_map_reverse
  :: IslUnionMapPtr -> IO IslUnionMapPtr

-- | Lexicographically less-than between two union maps
foreign import capi "isl/union_map.h isl_union_map_lex_lt_union_map" c_isl_union_map_lex_lt_union_map
  :: IslUnionMapPtr -> IslUnionMapPtr -> IO IslUnionMapPtr

-- Haskell wrappers
islUnionMapReadFromStr :: IslCtxPtr -> String -> IO IslUnionMapPtr
islUnionMapReadFromStr ctx str = withCString str $ \cstr ->
  c_isl_union_map_read_from_str ctx cstr

islUnionMapApplyRange :: IslUnionMapPtr -> IslUnionMapPtr -> IO IslUnionMapPtr
islUnionMapApplyRange = c_isl_union_map_apply_range

islUnionMapReverse :: IslUnionMapPtr -> IO IslUnionMapPtr
islUnionMapReverse = c_isl_union_map_reverse

islUnionMapLexLtUnionMap :: IslUnionMapPtr -> IslUnionMapPtr -> IO IslUnionMapPtr
islUnionMapLexLtUnionMap = c_isl_union_map_lex_lt_union_map 