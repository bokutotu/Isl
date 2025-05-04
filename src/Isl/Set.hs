module Isl.Set
  ( Set (..),
    readFromStr,
    coalesce,
    samplePoint,
    fixVal,
  )
where

import Foreign.C.Types (CInt)
import Foreign.Isl.Set
  ( IslSetPtr,
    islSetCoalesce,
    islSetFixVal,
    islSetReadFromStr,
    islSetSamplePoint,
  )
import Isl.Ctx (Ctx (..))
import Isl.DimType (DimType, dimTypeToInt)
import Isl.Val (Val (..))
import System.IO.Unsafe (unsafePerformIO)

-- | A safe wrapper around IslSet
newtype Set = Set IslSetPtr

-- | Read a set from a string
readFromStr :: Ctx -> String -> Maybe Set
readFromStr (Ctx ctx) str =
  Just $ Set $ unsafePerformIO $ islSetReadFromStr ctx str

-- | Coalesce a set
coalesce :: Set -> Maybe Set
coalesce (Set ptr) =
  Just $ Set $ unsafePerformIO $ islSetCoalesce ptr

-- | Get a sample point from a set
samplePoint :: Set -> Maybe Set
samplePoint (Set ptr) =
  Just $ Set $ unsafePerformIO $ islSetSamplePoint ptr

fixVal :: Set -> DimType -> Word -> Val -> Maybe Set
fixVal (Set p) ty i v =
  Just . Set $ unsafePerformIO (islSetFixVal p (fromIntegral (dimTypeToInt ty) :: CInt) i (unVal v))
{-# NOINLINE fixVal #-}
