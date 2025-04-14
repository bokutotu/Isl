module Main (main) where

import Isl.Ctx (withIslCtx) -- Import the safe wrapper

main :: IO ()
main = do
  putStrLn "Running Isl Ctx test..."
  withIslCtx $ \_ctx -> do
    -- We don't actually *do* anything with the context yet,
    -- but this demonstrates allocation and freeing via bracket.
    putStrLn "  Successfully allocated and will free IslCtx."
  putStrLn "Test finished."
