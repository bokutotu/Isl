module Main (main) where

import Isl.Ctx (sayHello)

main :: IO ()
main = do
  print sayHello
