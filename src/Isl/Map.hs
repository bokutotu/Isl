module Isl.Map
  ( Map (..),
    readFromStr,
    reverse,
    lexMin,
    lexMax,
  )
where

import Foreign.Isl.Map
import Isl.Ctx (Ctx (..))
import System.IO.Unsafe (unsafePerformIO)
import Prelude hiding (reverse)

-- | A safe wrapper around IslMap
newtype Map = Map {unMap :: IslMapPtr}

-- | Read a map from a string
readFromStr :: Ctx -> String -> Maybe Map
readFromStr (Ctx ctx) str =
  Just $ Map $ unsafePerformIO $ islMapReadFromStr ctx str

-- | Reverse a map
reverse :: Map -> Maybe Map
reverse (Map ptr) =
  Just $ Map $ unsafePerformIO $ islMapReverse ptr

-- | Lexicographic minimum
lexMin :: Map -> Maybe Map
lexMin (Map ptr) =
  Just $ Map $ unsafePerformIO $ islMapLexMin ptr

-- | Lexicographic maximum
lexMax :: Map -> Maybe Map
lexMax (Map ptr) =
  Just $ Map $ unsafePerformIO $ islMapLexMax ptr
