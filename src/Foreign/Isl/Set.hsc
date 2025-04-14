{-# LANGUAGE ForeignFunctionInterface #-}

module Foreign.Isl.Set 
  ( IslSet(..)
  , islSetReadFromStr
  ) where

import Foreign.Ptr (Ptr)
import Foreign.C.String (CString)
import Foreign.Isl.Ctx (IslCtx(..))

#include <isl/set.h>

newtype IslSet = IslSet (Ptr IslSet)

foreign import ccall unsafe "isl_set_read_from_str"
  islSetReadFromStr :: Ptr IslCtx -> CString -> IO (Ptr IslSet)
