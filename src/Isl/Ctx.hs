module Isl.Ctx
  ( Ctx
  , newCtx
  , getMaxOperations
  , setMaxOperations
  ) where

import Foreign.Isl.Ctx
import Foreign.C.Types
import System.IO.Unsafe (unsafePerformIO)

-- | A safe wrapper around IslCtx
newtype Ctx = Ctx { unCtx :: IslCtxPtr }

-- | Create a new ISL context
-- Note: This function will never return Nothing in practice,
-- but we use Maybe to maintain a pure interface
newCtx :: Maybe Ctx
newCtx = Just $ Ctx $ unsafePerformIO islCtxAlloc

-- | Get the maximum number of operations
getMaxOperations :: Ctx -> Integer
getMaxOperations (Ctx ptr) = 
  fromIntegral $ unsafePerformIO $ islCtxGetMaxOperations ptr

-- | Set the maximum number of operations
setMaxOperations :: Ctx -> Integer -> ()
setMaxOperations (Ctx ptr) val = 
  unsafePerformIO $ islCtxSetMaxOperations ptr (fromIntegral val)
