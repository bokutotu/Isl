module Isl.Map
  ( Map
  , readFromStr
  , reverse
  ) where

import Foreign.Isl.Map
import Foreign.Isl.Ctx
import System.IO.Unsafe (unsafePerformIO)
import Isl.Ctx (Ctx(..))
import Prelude hiding (reverse)

-- | A safe wrapper around IslMap
newtype Map = Map { unMap :: IslMapPtr }

-- | Read a map from a string
readFromStr :: Ctx -> String -> Maybe Map
readFromStr (Ctx ctx) str = 
  Just $ Map $ unsafePerformIO $ islMapReadFromStr ctx str

-- | Reverse a map
reverse :: Map -> Maybe Map
reverse (Map ptr) = 
  Just $ Map $ unsafePerformIO $ islMapReverse ptr 