{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Val
  ( IslVal
  , IslValPtr
  , islValZero
  , islValOne
  , islValNegone
  , islValNan
  , islValInfty
  , islValNeginfty
  , islValIntFromSi
  , islValIntFromUi
  , islValReadFromStr
  , islValSgn
  , islValIsZero
  , islValIsOne
  , islValIsNegone
  , islValIsNan
  , islValIsInfty
  , islValIsNeginfty
  , islValEq
  , islValNe
  , islValLt
  , islValGt
  , islValLe
  , islValGe
  , islValAdd
  , islValSub
  , islValMul
  , islValDiv
  , islValToStr
  , islValCopy
  , islValFree
  ) where

import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Isl.Ctx

#include <isl/val.h>

-- | The ISL val structure
data IslVal

type IslValPtr = Ptr IslVal

foreign import capi "isl/val.h isl_val_zero" c_isl_val_zero
  :: IslCtxPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_one" c_isl_val_one
  :: IslCtxPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_negone" c_isl_val_negone
  :: IslCtxPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_nan" c_isl_val_nan
  :: IslCtxPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_infty" c_isl_val_infty
  :: IslCtxPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_neginfty" c_isl_val_neginfty
  :: IslCtxPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_int_from_si" c_isl_val_int_from_si
  :: IslCtxPtr -> CLong -> IO IslValPtr
foreign import capi "isl/val.h isl_val_int_from_ui" c_isl_val_int_from_ui
  :: IslCtxPtr -> CULong -> IO IslValPtr
foreign import capi "isl/val.h isl_val_read_from_str" c_isl_val_read_from_str
  :: IslCtxPtr -> CString -> IO IslValPtr
foreign import capi "isl/val.h isl_val_sgn" c_isl_val_sgn
  :: IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_is_zero" c_isl_val_is_zero
  :: IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_is_one" c_isl_val_is_one
  :: IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_is_negone" c_isl_val_is_negone
  :: IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_is_nan" c_isl_val_is_nan
  :: IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_is_infty" c_isl_val_is_infty
  :: IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_is_neginfty" c_isl_val_is_neginfty
  :: IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_eq" c_isl_val_eq
  :: IslValPtr -> IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_ne" c_isl_val_ne
  :: IslValPtr -> IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_lt" c_isl_val_lt
  :: IslValPtr -> IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_gt" c_isl_val_gt
  :: IslValPtr -> IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_le" c_isl_val_le
  :: IslValPtr -> IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_ge" c_isl_val_ge
  :: IslValPtr -> IslValPtr -> IO CInt
foreign import capi "isl/val.h isl_val_add" c_isl_val_add
  :: IslValPtr -> IslValPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_sub" c_isl_val_sub
  :: IslValPtr -> IslValPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_mul" c_isl_val_mul
  :: IslValPtr -> IslValPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_div" c_isl_val_div
  :: IslValPtr -> IslValPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_to_str" c_isl_val_to_str
  :: IslValPtr -> IO CString
foreign import capi "isl/val.h isl_val_copy" c_isl_val_copy
  :: IslValPtr -> IO IslValPtr
foreign import capi "isl/val.h isl_val_free" c_isl_val_free
  :: IslValPtr -> IO ()

-- Haskell wrappers
islValZero :: IslCtxPtr -> IO IslValPtr
islValZero = c_isl_val_zero
islValOne :: IslCtxPtr -> IO IslValPtr
islValOne = c_isl_val_one
islValNegone :: IslCtxPtr -> IO IslValPtr
islValNegone = c_isl_val_negone
islValNan :: IslCtxPtr -> IO IslValPtr
islValNan = c_isl_val_nan
islValInfty :: IslCtxPtr -> IO IslValPtr
islValInfty = c_isl_val_infty
islValNeginfty :: IslCtxPtr -> IO IslValPtr
islValNeginfty = c_isl_val_neginfty
islValIntFromSi :: IslCtxPtr -> CLong -> IO IslValPtr
islValIntFromSi = c_isl_val_int_from_si
islValIntFromUi :: IslCtxPtr -> CULong -> IO IslValPtr
islValIntFromUi = c_isl_val_int_from_ui
islValReadFromStr :: IslCtxPtr -> String -> IO IslValPtr
islValReadFromStr ctx str = withCString str $ \cstr -> c_isl_val_read_from_str ctx cstr
islValSgn :: IslValPtr -> IO CInt
islValSgn = c_isl_val_sgn
islValIsZero :: IslValPtr -> IO CInt
islValIsZero = c_isl_val_is_zero
islValIsOne :: IslValPtr -> IO CInt
islValIsOne = c_isl_val_is_one
islValIsNegone :: IslValPtr -> IO CInt
islValIsNegone = c_isl_val_is_negone
islValIsNan :: IslValPtr -> IO CInt
islValIsNan = c_isl_val_is_nan
islValIsInfty :: IslValPtr -> IO CInt
islValIsInfty = c_isl_val_is_infty
islValIsNeginfty :: IslValPtr -> IO CInt
islValIsNeginfty = c_isl_val_is_neginfty
islValEq :: IslValPtr -> IslValPtr -> IO CInt
islValEq = c_isl_val_eq
islValNe :: IslValPtr -> IslValPtr -> IO CInt
islValNe = c_isl_val_ne
islValLt :: IslValPtr -> IslValPtr -> IO CInt
islValLt = c_isl_val_lt
islValGt :: IslValPtr -> IslValPtr -> IO CInt
islValGt = c_isl_val_gt
islValLe :: IslValPtr -> IslValPtr -> IO CInt
islValLe = c_isl_val_le
islValGe :: IslValPtr -> IslValPtr -> IO CInt
islValGe = c_isl_val_ge
islValAdd :: IslValPtr -> IslValPtr -> IO IslValPtr
islValAdd = c_isl_val_add
islValSub :: IslValPtr -> IslValPtr -> IO IslValPtr
islValSub = c_isl_val_sub
islValMul :: IslValPtr -> IslValPtr -> IO IslValPtr
islValMul = c_isl_val_mul
islValDiv :: IslValPtr -> IslValPtr -> IO IslValPtr
islValDiv = c_isl_val_div
islValToStr :: IslValPtr -> IO CString
islValToStr = c_isl_val_to_str
islValCopy :: IslValPtr -> IO IslValPtr
islValCopy = c_isl_val_copy
islValFree :: IslValPtr -> IO ()
islValFree = c_isl_val_free 