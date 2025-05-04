{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Printer
  ( islPrinterToStr
  , islPrinterFree
  , islPrinterGetStr
  , islPrinterSetIndent
  , islPrinterSetOutputFormat
  , islPrinterPrintStr
  , islPrinterPrintSchedule
  , islPrinterFlush
  ) where

import Foreign.C.Types
import Foreign.C.String
import Foreign.Isl.Ctx
import Foreign.Isl.Schedule
import Foreign.Isl.PrinterTypes

#include <isl/printer.h>

foreign import capi "isl/printer.h isl_printer_to_str" c_isl_printer_to_str
  :: IslCtxPtr -> IO IslPrinterPtr

foreign import capi "isl/printer.h isl_printer_free" c_isl_printer_free
  :: IslPrinterPtr -> IO IslPrinterPtr

foreign import capi "isl/printer.h isl_printer_get_str" c_isl_printer_get_str
  :: IslPrinterPtr -> IO CString

foreign import capi "isl/printer.h isl_printer_set_indent" c_isl_printer_set_indent
  :: IslPrinterPtr -> CInt -> IO IslPrinterPtr

foreign import capi "isl/printer.h isl_printer_set_output_format" c_isl_printer_set_output_format
  :: IslPrinterPtr -> CInt -> IO IslPrinterPtr

foreign import capi "isl/printer.h isl_printer_print_str" c_isl_printer_print_str
  :: IslPrinterPtr -> CString -> IO IslPrinterPtr

foreign import capi "isl/printer.h isl_printer_flush"
  c_isl_printer_flush
  :: IslPrinterPtr -> IO IslPrinterPtr

-- Haskell wrappers
islPrinterToStr :: IslCtxPtr -> IO IslPrinterPtr
islPrinterToStr = c_isl_printer_to_str

islPrinterFree :: IslPrinterPtr -> IO IslPrinterPtr
islPrinterFree = c_isl_printer_free

islPrinterGetStr :: IslPrinterPtr -> IO CString
islPrinterGetStr = c_isl_printer_get_str

islPrinterSetIndent :: IslPrinterPtr -> Int -> IO IslPrinterPtr
islPrinterSetIndent p n = c_isl_printer_set_indent p (fromIntegral n)

islPrinterSetOutputFormat :: IslPrinterPtr -> Int -> IO IslPrinterPtr
islPrinterSetOutputFormat p fmt = c_isl_printer_set_output_format p (fromIntegral fmt)

islPrinterPrintStr :: IslPrinterPtr -> String -> IO IslPrinterPtr
islPrinterPrintStr p s = withCString s $ \cs -> c_isl_printer_print_str p cs 

islPrinterFlush :: IslPrinterPtr -> IO IslPrinterPtr
islPrinterFlush = c_isl_printer_flush
