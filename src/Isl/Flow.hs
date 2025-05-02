module Isl.Flow
  ( AccessInfo
  , Flow
  , computeFlow
  ) where

import Foreign.Isl.Flow
import Foreign.Isl.UnionMap
import System.IO.Unsafe (unsafePerformIO)
import Isl.UnionMap (UnionMap(..))
import Foreign.Ptr (Ptr, nullPtr)
import Foreign.Marshal.Alloc (alloca)
import Foreign.Storable (peek)

-- | A safe wrapper around IslAccessInfo
newtype AccessInfo = AccessInfo { unAccessInfo :: IslAccessInfoPtr }

-- | A safe wrapper around IslFlow
newtype Flow = Flow { unFlow :: IslFlowPtr }

-- | Compute flow dependencies
-- Returns (must_dep, may_dep, must_no_source, may_no_source) if successful
computeFlow :: UnionMap  -- ^ sink
           -> UnionMap  -- ^ must_source
           -> UnionMap  -- ^ may_source
           -> UnionMap  -- ^ schedule
           -> Maybe (UnionMap, UnionMap, UnionMap, UnionMap)
computeFlow (UnionMap sink) (UnionMap must_source) (UnionMap may_source) (UnionMap schedule) = 
  unsafePerformIO $ alloca $ \must_dep ->
    alloca $ \may_dep ->
      alloca $ \must_no_source ->
        alloca $ \may_no_source -> do
          ret <- islUnionMapComputeFlow sink must_source may_source schedule 
                                       must_dep may_dep must_no_source may_no_source
          if ret == 0
            then do
              must_dep_val <- peek must_dep
              may_dep_val <- peek may_dep
              must_no_source_val <- peek must_no_source
              may_no_source_val <- peek may_no_source
              return $ Just ( UnionMap must_dep_val
                          , UnionMap may_dep_val
                          , UnionMap must_no_source_val
                          , UnionMap may_no_source_val
                          )
            else return Nothing 