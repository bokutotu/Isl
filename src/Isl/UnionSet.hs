module Isl.UnionSet
  ( UnionSet(..)
  , readFromStr
  , union
  ) where

import Foreign.Isl.UnionSet
import Foreign.Isl.Ctx
import System.IO.Unsafe (unsafePerformIO)
import Isl.Ctx (Ctx(..))
import Prelude hiding (union)

-- | A safe wrapper around IslUnionSet
newtype UnionSet = UnionSet { unUnionSet :: IslUnionSetPtr }

-- | Read a union set from a string
readFromStr :: Ctx -> String -> Maybe UnionSet
readFromStr (Ctx ctx) str = 
  Just $ UnionSet $ unsafePerformIO $ islUnionSetReadFromStr ctx str

-- | Compute the union of two union sets
union :: UnionSet -> UnionSet -> Maybe UnionSet
union (UnionSet ptr1) (UnionSet ptr2) = 
  Just $ UnionSet $ unsafePerformIO $ islUnionSetUnion ptr1 ptr2 