{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.PrinterTypes
  ( IslPrinter
  , IslPrinterPtr
  ) where

import Foreign.Ptr

#include <isl/printer.h>

data IslPrinter

type IslPrinterPtr = Ptr IslPrinter
