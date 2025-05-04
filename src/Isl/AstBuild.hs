module Isl.AstBuild
  ( AstBuild
  , AstNode
  , buildFromSchedule
  , buildSetAtEachDomain
  , astBuildAlloc
  , astBuildNodeFromSchedule
  , printerPrintAstNode
  )
where

import Foreign.Isl.AstBuild
import Foreign.Isl.AstBuildTypes
import Foreign.Ptr (nullPtr)
import Isl.Ctx (Ctx (..))
import Isl.Schedule (Schedule (..))
import System.IO.Unsafe (unsafePerformIO)
import Isl.Printer (Printer (Printer, unPrinter))

-- | A safe wrapper around IslAstBuild
newtype AstBuild = AstBuild IslAstBuildPtr

-- | A safe wrapper around IslAstNode
newtype AstNode = AstNode IslAstNodePtr

-- | Build an AST from a schedule
buildFromSchedule :: AstBuild -> Schedule -> Maybe AstNode
buildFromSchedule (AstBuild bld) (Schedule sch) =
  Just $ AstNode $ unsafePerformIO $ islAstBuildFromSchedule bld sch

-- | Set a callback at each domain (not implemented, just passes nullPtr)
buildSetAtEachDomain :: AstBuild -> AstBuild
buildSetAtEachDomain (AstBuild bld) =
  AstBuild $ unsafePerformIO $ islAstBuildSetAtEachDomain bld nullPtr nullPtr

astBuildAlloc :: Ctx -> AstBuild
astBuildAlloc ctx =
  AstBuild $ unsafePerformIO $ islAstBuildAlloc $ unCtx ctx

astBuildNodeFromSchedule :: AstBuild -> Schedule -> Maybe AstNode
astBuildNodeFromSchedule (AstBuild bld) (Schedule sch) =
  Just $ AstNode $ unsafePerformIO $ islAstBuildNodeFromSchedule bld sch

printerPrintAstNode :: Printer -> AstNode -> Maybe Printer
printerPrintAstNode p (AstNode node) =
  Just $ Printer $ unsafePerformIO $ islPrinterPrintAstNode ( unPrinter p ) node
