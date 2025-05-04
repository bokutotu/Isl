module Isl.Printer
  ( Printer (..),
    toStrPrinter,
    free,
    getStr,
    setIndent,
    setOutputFormat,
    printStr,
    OutFromat (..),
  )
where

import Foreign.C.String (peekCString)
import Foreign.Isl.Printer
import Isl.Ctx (Ctx (..))
import System.IO.Unsafe (unsafePerformIO)

newtype Printer = Printer {unPrinter :: IslPrinterPtr}

data OutFromat
  = C
  | Isl
  | Poly
  deriving (Show, Eq)

formatToInt :: OutFromat -> Int
formatToInt C = 4
formatToInt Isl = 0
formatToInt Poly = 1

toStrPrinter :: Ctx -> Printer
toStrPrinter (Ctx ctx) = Printer $ unsafePerformIO $ islPrinterToStr ctx

free :: Printer -> Printer
free (Printer p) = Printer $ unsafePerformIO $ islPrinterFree p

getStr :: Printer -> String
getStr (Printer p) = unsafePerformIO $ islPrinterGetStr p >>= peekCString

setIndent :: Printer -> Int -> Printer
setIndent (Printer p) n = Printer $ unsafePerformIO $ islPrinterSetIndent p n

setOutputFormat :: Printer -> OutFromat -> Printer
setOutputFormat (Printer p) fmt = Printer $ unsafePerformIO $ islPrinterSetOutputFormat p $ formatToInt fmt

printStr :: Printer -> String -> Printer
printStr (Printer p) s = Printer $ unsafePerformIO $ islPrinterPrintStr p s
