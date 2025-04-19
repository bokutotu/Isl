{-# LANGUAGE ForeignFunctionInterface #-}

module Foreign.Isl.Id
  ( IslId(..)
  , islIdAlloc
  , islIdFree
  ) where

import Foreign.Ptr (Ptr)
import Foreign.C.String (CString)
import Foreign.Isl.Ctx (IslCtx(..))

#include <isl/id.h>

newtype IslId = IslId (Ptr IslId)

foreign import ccall unsafe "isl_id_alloc"
  islIdAlloc :: Ptr IslCtx -> CString -> Ptr () -> IO (Ptr IslId)

foreign import ccall unsafe "isl_id_free"
  islIdFree :: Ptr IslId -> IO (Ptr IslId)
