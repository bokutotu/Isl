module Isl.AstBuild
  ( AstBuild (..)
  , AstNode (..)
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
import Isl.UnionMap (UnionMap (unUnionMap))

-- | A safe wrapper around IslAstBuild
newtype AstBuild = AstBuild { unAstBuild :: IslAstBuildPtr }

-- | A safe wrapper around IslAstNode
newtype AstNode = AstNode { unAstNode :: IslAstNodePtr }

-- | Build an AST from a schedule
buildFromSchedule :: AstBuild -> UnionMap -> Maybe AstNode
buildFromSchedule bld sch =
  Just $ AstNode $ unsafePerformIO $ islAstBuildFromSchedule ( unAstBuild bld ) ( unUnionMap sch )

-- | Set a callback at each domain (not implemented, just passes nullPtr)
buildSetAtEachDomain :: AstBuild -> AstBuild
buildSetAtEachDomain bld =
  AstBuild $ unsafePerformIO $ islAstBuildSetAtEachDomain ( unAstBuild bld ) nullPtr nullPtr

astBuildAlloc :: Ctx -> AstBuild
astBuildAlloc ctx =
  AstBuild $ unsafePerformIO $ islAstBuildAlloc $ unCtx ctx

astBuildNodeFromSchedule :: AstBuild -> Schedule -> Maybe AstNode
astBuildNodeFromSchedule bld sch =
  Just $ AstNode $ unsafePerformIO $ islAstBuildNodeFromSchedule (unAstBuild bld ) ( unSchedule sch )

printerPrintAstNode :: Printer -> AstNode -> Maybe Printer
printerPrintAstNode p node =
  Just $ Printer $ unsafePerformIO $ islPrinterPrintAstNode ( unPrinter p ) ( unAstNode node )
