import Isl.AstBuild (astBuildAlloc, buildFromSchedule)
import Isl.Ctx (newCtx)
import Isl.Set (readFromStr, fixVal)
import Isl.Schedule (scheduleFromDomain)
import Isl.UnionSet (unionSetFromSet)
import Isl.Val (intFromSi)
import Isl.DimType (DimType (..))
import Isl.Printer (toStrPrinter, setOutputFormat, getStr, OutFromat (..))

orFail :: String -> Maybe a -> IO a
orFail msg = maybe (fail msg) pure

(??) :: Maybe a -> String -> IO a
m ?? msg = orFail msg m
infixl 1 ??

main :: IO ()
main = do
  ctx     <- newCtx ?? "ISL context の生成に失敗しました"
  domain0 <- readFromStr ctx "[n] -> { S[i] : 0 <= i < n }"
              ?? "ISL domain の生成に失敗しました"
  nVal    <- intFromSi ctx 5 ?? "ISL Val の生成に失敗しました"
  domain1 <- fixVal domain0 DimIn 0 nVal
              ?? "ISL domain の生成に失敗しました"

  let domainUs = unionSetFromSet domain1
  schedule <- scheduleFromDomain domainUs
              ?? "ISL schedule の生成に失敗しました"

  let astBuild = astBuildAlloc ctx
  root <- buildFromSchedule astBuild schedule
            ?? "ISL AST の生成に失敗しました"

  let printer0 = toStrPrinter ctx
  let printer1 = setOutputFormat printer0 C
  let str = getStr printer1

  putStrLn str
