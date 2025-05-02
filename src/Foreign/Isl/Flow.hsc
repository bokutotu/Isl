{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Flow
  ( IslAccessInfo
  , IslAccessInfoPtr
  , IslRestriction
  , IslRestrictionPtr
  , IslFlow
  , IslFlowPtr
  , islAccessInfoAlloc
  , islAccessInfoSetRestrict
  , islUnionMapComputeFlow
  ) where

import Foreign.Ptr
import Foreign.C.Types
import Foreign.Isl.Ctx
import Foreign.Isl.UnionMap
import Foreign.Isl.Map

#include <isl/flow.h>

-- | The ISL access info structure
data IslAccessInfo

-- | Opaque type for isl_access_info
type IslAccessInfoPtr = Ptr IslAccessInfo

-- | The ISL restriction structure
data IslRestriction

-- | Opaque type for isl_restriction
type IslRestrictionPtr = Ptr IslRestriction

-- | The ISL flow structure
data IslFlow

-- | Opaque type for isl_flow
type IslFlowPtr = Ptr IslFlow

-- | Type for access level before function
type IslAccessLevelBeforeFn = FunPtr (Ptr () -> IO CInt)

-- | Type for access restrict function
type IslAccessRestrictFn = FunPtr (Ptr () -> IO CInt)

-- | Allocate an access info structure
foreign import capi "isl/flow.h isl_access_info_alloc" c_isl_access_info_alloc
  :: IslMapPtr -> Ptr () -> IslAccessLevelBeforeFn -> CInt -> IO IslAccessInfoPtr

-- | Set restriction on access info
foreign import capi "isl/flow.h isl_access_info_set_restrict" c_isl_access_info_set_restrict
  :: IslAccessInfoPtr -> IslAccessRestrictFn -> Ptr () -> IO IslAccessInfoPtr

-- | Compute flow dependencies
foreign import ccall "isl/flow.h isl_union_map_compute_flow" c_isl_union_map_compute_flow
  :: IslUnionMapPtr  -- sink
  -> IslUnionMapPtr  -- must_source
  -> IslUnionMapPtr  -- may_source
  -> IslUnionMapPtr  -- schedule
  -> Ptr (Ptr IslUnionMap)  -- must_dep
  -> Ptr (Ptr IslUnionMap)  -- may_dep
  -> Ptr (Ptr IslUnionMap)  -- must_no_source
  -> Ptr (Ptr IslUnionMap)  -- may_no_source
  -> IO CInt

-- Haskell wrappers
islAccessInfoAlloc :: IslMapPtr -> Ptr () -> IslAccessLevelBeforeFn -> CInt -> IO IslAccessInfoPtr
islAccessInfoAlloc = c_isl_access_info_alloc

islAccessInfoSetRestrict :: IslAccessInfoPtr -> IslAccessRestrictFn -> Ptr () -> IO IslAccessInfoPtr
islAccessInfoSetRestrict = c_isl_access_info_set_restrict

islUnionMapComputeFlow :: IslUnionMapPtr -> IslUnionMapPtr -> IslUnionMapPtr -> IslUnionMapPtr 
                      -> Ptr (Ptr IslUnionMap) -> Ptr (Ptr IslUnionMap) -> Ptr (Ptr IslUnionMap) -> Ptr (Ptr IslUnionMap)
                      -> IO CInt
islUnionMapComputeFlow = c_isl_union_map_compute_flow 