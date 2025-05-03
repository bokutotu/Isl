{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Id
  ( IslId
  , IslIdPtr
  , islIdAlloc
  , islIdCopy
  , islIdFree
  , islIdGetCtx
  , islIdGetHash
  , islIdGetName
  , islIdGetUser
  , islIdSetFreeUser
  , islIdGetFreeUser
  , islIdReadFromStr
  , islIdToStr
  , islIdDump
  , IslIdList
  , IslIdListPtr
  , IslMultiId
  , IslMultiIdPtr
  , islMultiIdReadFromStr
  , islMultiIdToStr
  , islMultiIdDump
  ) where

import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Isl.Ctx

#include <isl/id.h>

-- | The ISL id structure
data IslId

type IslIdPtr = Ptr IslId

data IslIdList

type IslIdListPtr = Ptr IslIdList

data IslMultiId

type IslMultiIdPtr = Ptr IslMultiId

-- isl_id functions
foreign import capi "isl/id.h isl_id_alloc" c_isl_id_alloc
  :: IslCtxPtr -> CString -> Ptr () -> IO IslIdPtr
foreign import capi "isl/id.h isl_id_copy" c_isl_id_copy
  :: IslIdPtr -> IO IslIdPtr
foreign import capi "isl/id.h isl_id_free" c_isl_id_free
  :: IslIdPtr -> IO ()
foreign import capi "isl/id.h isl_id_get_ctx" c_isl_id_get_ctx
  :: IslIdPtr -> IO IslCtxPtr
foreign import capi "isl/id.h isl_id_get_hash" c_isl_id_get_hash
  :: IslIdPtr -> IO CUInt
foreign import capi "isl/id.h isl_id_get_name" c_isl_id_get_name
  :: IslIdPtr -> IO CString
foreign import capi "isl/id.h isl_id_get_user" c_isl_id_get_user
  :: IslIdPtr -> IO (Ptr ())
foreign import capi "isl/id.h isl_id_set_free_user" c_isl_id_set_free_user
  :: IslIdPtr -> FunPtr (Ptr () -> IO ()) -> IO IslIdPtr
foreign import capi "isl/id.h isl_id_get_free_user" c_isl_id_get_free_user
  :: IslIdPtr -> IO (FunPtr (Ptr () -> IO ()))
foreign import capi "isl/id.h isl_id_read_from_str" c_isl_id_read_from_str
  :: IslCtxPtr -> CString -> IO IslIdPtr
foreign import capi "isl/id.h isl_id_to_str" c_isl_id_to_str
  :: IslIdPtr -> IO CString
foreign import capi "isl/id.h isl_id_dump" c_isl_id_dump
  :: IslIdPtr -> IO ()

-- isl_multi_id functions
foreign import capi "isl/id.h isl_multi_id_read_from_str" c_isl_multi_id_read_from_str
  :: IslCtxPtr -> CString -> IO IslMultiIdPtr
foreign import capi "isl/id.h isl_multi_id_to_str" c_isl_multi_id_to_str
  :: IslMultiIdPtr -> IO CString
foreign import capi "isl/id.h isl_multi_id_dump" c_isl_multi_id_dump
  :: IslMultiIdPtr -> IO ()

-- Haskell wrappers
islIdAlloc :: IslCtxPtr -> String -> Ptr () -> IO IslIdPtr
islIdAlloc ctx name user = withCString name $ \cname -> c_isl_id_alloc ctx cname user
islIdCopy :: IslIdPtr -> IO IslIdPtr
islIdCopy = c_isl_id_copy
islIdFree :: IslIdPtr -> IO ()
islIdFree = c_isl_id_free
islIdGetCtx :: IslIdPtr -> IO IslCtxPtr
islIdGetCtx = c_isl_id_get_ctx
islIdGetHash :: IslIdPtr -> IO CUInt
islIdGetHash = c_isl_id_get_hash
islIdGetName :: IslIdPtr -> IO CString
islIdGetName = c_isl_id_get_name
islIdGetUser :: IslIdPtr -> IO (Ptr ())
islIdGetUser = c_isl_id_get_user
islIdSetFreeUser :: IslIdPtr -> FunPtr (Ptr () -> IO ()) -> IO IslIdPtr
islIdSetFreeUser = c_isl_id_set_free_user
islIdGetFreeUser :: IslIdPtr -> IO (FunPtr (Ptr () -> IO ()))
islIdGetFreeUser = c_isl_id_get_free_user
islIdReadFromStr :: IslCtxPtr -> String -> IO IslIdPtr
islIdReadFromStr ctx str = withCString str $ \cstr -> c_isl_id_read_from_str ctx cstr
islIdToStr :: IslIdPtr -> IO CString
islIdToStr = c_isl_id_to_str
islIdDump :: IslIdPtr -> IO ()
islIdDump = c_isl_id_dump

islMultiIdReadFromStr :: IslCtxPtr -> String -> IO IslMultiIdPtr
islMultiIdReadFromStr ctx str = withCString str $ \cstr -> c_isl_multi_id_read_from_str ctx cstr
islMultiIdToStr :: IslMultiIdPtr -> IO CString
islMultiIdToStr = c_isl_multi_id_to_str
islMultiIdDump :: IslMultiIdPtr -> IO ()
islMultiIdDump = c_isl_multi_id_dump 
