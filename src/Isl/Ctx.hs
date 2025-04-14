module Isl.Ctx
  ( IslCtx -- Export the type, but not the constructor
  , withIslCtx
  ) where

import Control.Exception (bracket)
import qualified Foreign.Isl.Ctx as Raw

-- | Represents an ISL context. The underlying pointer is managed
-- automatically when using 'withIslCtx'.
newtype IslCtx = Wrap Raw.IslCtx

-- | Provides a safe way to allocate and release an 'IslCtx'.
-- The context is guaranteed to be freed even if exceptions occur
-- within the action.
--
-- Usage:
-- > withIslCtx $ \ctx -> do
-- >   -- Use the safe ctx :: IslCtx here
-- >   ...
withIslCtx :: (IslCtx -> IO a) -> IO a
withIslCtx action = bracket Raw.islCtxAlloc Raw.islCtxFree (action . Wrap)
-- Now passes the wrapped 'IslCtx' type to the user action, utilizing 'Wrap'.
