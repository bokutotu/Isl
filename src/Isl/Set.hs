module Isl.Set
  ( Set,
    readFromStr,
    coalesce,
    samplePoint,
  )
where

import Foreign.Isl.Set
import Isl.Ctx (Ctx (..))
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
