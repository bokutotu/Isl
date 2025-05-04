{-# LANGUAGE OverloadedStrings #-}

import Isl.AstBuild (astBuildAlloc, astBuildNodeFromSchedule, printerPrintAstNode)
import Isl.Ctx (newCtx)
import Isl.Printer (OutFromat (..), getStr, setOutputFormat, toStrPrinter)
import Isl.Schedule (scheduleFromDomain)
import Isl.Set (readFromStr)
import Isl.UnionSet (unionSetFromSet)

orFail :: String -> Maybe a -> IO a
orFail msg = maybe (fail msg) pure

infixl 1 ??

(??) :: Maybe a -> String -> IO a
m ?? msg = orFail msg m

main :: IO ()
main = do
  ctx <- newCtx ?? "ctx 生成失敗"
  domain <-
    readFromStr ctx "{ S[i] : 0 <= i < 5 }"
      ?? "domain 生成失敗"

  let domainUs = unionSetFromSet domain
  schedule <- scheduleFromDomain domainUs ?? "schedule 生成失敗"
  let astBuild = astBuildAlloc ctx
  root <-
    astBuildNodeFromSchedule astBuild schedule
      ?? "AST 生成失敗"

  let printer0 = toStrPrinter ctx
  let printer1 = setOutputFormat printer0 C
  printer2 <-
    printerPrintAstNode printer1 root
      ?? "印字失敗"
  putStrLn $ getStr printer2
