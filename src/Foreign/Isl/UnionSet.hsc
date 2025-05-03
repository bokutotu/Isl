{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.UnionSet
  ( IslUnionSet
  , IslUnionSetPtr
  , islUnionSetReadFromStr
  , islUnionSetUnion
  ) where

import Foreign.Ptr
import Foreign.C.String
import Foreign.Isl.Ctx

#include <isl/union_set.h>

-- | The ISL union set structure
data IslUnionSet

-- | Opaque type for isl_union_set
type IslUnionSetPtr = Ptr IslUnionSet

-- | Read a union set from a string
foreign import capi "isl/union_set.h isl_union_set_read_from_str" c_isl_union_set_read_from_str
  :: IslCtxPtr -> CString -> IO IslUnionSetPtr

-- | Compute the union of two union sets
foreign import capi "isl/union_set.h isl_union_set_union" c_isl_union_set_union
  :: IslUnionSetPtr -> IslUnionSetPtr -> IO IslUnionSetPtr

-- Haskell wrappers
islUnionSetReadFromStr :: IslCtxPtr -> String -> IO IslUnionSetPtr
islUnionSetReadFromStr ctx str = withCString str $ \cstr ->
  c_isl_union_set_read_from_str ctx cstr

islUnionSetUnion :: IslUnionSetPtr -> IslUnionSetPtr -> IO IslUnionSetPtr
islUnionSetUnion = c_isl_union_set_union 
