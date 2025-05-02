module Isl.UnionMap
  ( UnionMap(..)
  , readFromStr
  , applyRange
  , reverse
  , lexLtUnionMap
  ) where

import Foreign.Isl.UnionMap
import Foreign.Isl.Ctx
import System.IO.Unsafe (unsafePerformIO)
import Isl.Ctx (Ctx(..))
import Prelude hiding (reverse)

-- | A safe wrapper around IslUnionMap
newtype UnionMap = UnionMap { unUnionMap :: IslUnionMapPtr }

-- | Read a union map from a string
readFromStr :: Ctx -> String -> Maybe UnionMap
readFromStr (Ctx ctx) str = 
  Just $ UnionMap $ unsafePerformIO $ islUnionMapReadFromStr ctx str

-- | Apply range
applyRange :: UnionMap -> UnionMap -> Maybe UnionMap
applyRange (UnionMap ptr1) (UnionMap ptr2) = 
  Just $ UnionMap $ unsafePerformIO $ islUnionMapApplyRange ptr1 ptr2

-- | Reverse a union map
reverse :: UnionMap -> Maybe UnionMap
reverse (UnionMap ptr) = 
  Just $ UnionMap $ unsafePerformIO $ islUnionMapReverse ptr

-- | Lexicographically less-than between two union maps
lexLtUnionMap :: UnionMap -> UnionMap -> Maybe UnionMap
lexLtUnionMap (UnionMap ptr1) (UnionMap ptr2) =
  Just $ UnionMap $ unsafePerformIO $ islUnionMapLexLtUnionMap ptr1 ptr2 