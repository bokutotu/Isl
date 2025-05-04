module Isl.Id
  ( Id (..),
    alloc,
    copy,
    getName,
    getHash,
    toStr,
    readFromStr,
    dump,
    MultiId (..),
    multiIdReadFromStr,
    multiIdToStr,
    multiIdDump,
  )
where

import Foreign.C.String (peekCString)
import Foreign.Isl.Id
import Foreign.Ptr (nullPtr)
import Isl.Ctx (Ctx (..))
import System.IO.Unsafe (unsafePerformIO)

newtype Id = Id {unId :: IslIdPtr}

newtype MultiId = MultiId {unMultiId :: IslMultiIdPtr}

alloc :: Ctx -> String -> Id
alloc (Ctx ctx) name = Id $ unsafePerformIO $ islIdAlloc ctx name nullPtr

copy :: Id -> Id
copy (Id ptr) = Id $ unsafePerformIO $ islIdCopy ptr

getName :: Id -> String
getName (Id ptr) = unsafePerformIO $ islIdGetName ptr >>= peekCString

getHash :: Id -> Int
getHash (Id ptr) = fromIntegral $ unsafePerformIO $ islIdGetHash ptr

toStr :: Id -> String
toStr (Id ptr) = unsafePerformIO $ islIdToStr ptr >>= peekCString

readFromStr :: Ctx -> String -> Id
readFromStr (Ctx ctx) str = Id $ unsafePerformIO $ islIdReadFromStr ctx str

dump :: Id -> IO ()
dump (Id ptr) = islIdDump ptr

multiIdReadFromStr :: Ctx -> String -> MultiId
multiIdReadFromStr (Ctx ctx) str = MultiId $ unsafePerformIO $ islMultiIdReadFromStr ctx str

multiIdToStr :: MultiId -> String
multiIdToStr (MultiId ptr) = unsafePerformIO $ islMultiIdToStr ptr >>= peekCString

multiIdDump :: MultiId -> IO ()
multiIdDump (MultiId ptr) = islMultiIdDump ptr
