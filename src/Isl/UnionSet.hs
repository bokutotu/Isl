module Isl.UnionSet
  ( UnionSet (..)
  , readFromStr
  , union
  , unionSetFromSet
  )
where

import Foreign.Isl.UnionSet
import Isl.Ctx (Ctx (..))
import Isl.Set (Set (..))
import System.IO.Unsafe (unsafePerformIO)

-- | A safe wrapper around IslUnionSet
newtype UnionSet = UnionSet {unUnionSet :: IslUnionSetPtr}

-- | Read a union set from a string
readFromStr :: Ctx -> String -> Maybe UnionSet
readFromStr (Ctx ctx) str =
  Just $ UnionSet $ unsafePerformIO $ islUnionSetReadFromStr ctx str

-- | Compute the union of two union sets
union :: UnionSet -> UnionSet -> Maybe UnionSet
union (UnionSet ptr1) (UnionSet ptr2) =
  Just $ UnionSet $ unsafePerformIO $ islUnionSetUnion ptr1 ptr2

unionSetFromSet :: Set -> UnionSet
unionSetFromSet (Set ptr) =
  UnionSet $ unsafePerformIO $ islUnionSetFromSet ptr
