module Main (main) where

import Isl.Ctx (initIslCtx)

main :: IO ()
main = do
  putStrLn "Running Isl Ctx test..."
  let maybeCtx = initIslCtx
  case maybeCtx of
    Nothing -> do
      putStrLn "  Failed to allocate IslCtx."
    Just _ctx -> do
      putStrLn "  Successfully allocated IslCtx (but NOT freed)."
  putStrLn "Test finished."
