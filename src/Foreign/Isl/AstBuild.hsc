{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.AstBuild
  ( IslAstBuild
  , IslAstBuildPtr
  , IslAstNode
  , IslAstNodePtr
  , islAstBuildFromSchedule
  , islAstBuildSetAtEachDomain
  , islAstBuildAlloc
  , islAstBuildNodeFromSchedule
  ) where

import Foreign.Ptr
import Foreign.Isl.Schedule
import Foreign.Isl.Ctx

#include <isl/ast_build.h>
#include <isl/ast.h>

-- | The ISL ast build structure
data IslAstBuild

type IslAstBuildPtr = Ptr IslAstBuild

-- | The ISL ast node structure
data IslAstNode

type IslAstNodePtr = Ptr IslAstNode

-- | Build an AST from a schedule (correct function name)
foreign import capi "isl/ast_build.h isl_ast_build_ast_from_schedule" c_isl_ast_build_ast_from_schedule
  :: IslAstBuildPtr -> IslSchedulePtr -> IO IslAstNodePtr

-- | Set a callback at each domain (stub: callback not supported in this binding)
foreign import capi "isl/ast_build.h isl_ast_build_set_at_each_domain" c_isl_ast_build_set_at_each_domain
  :: IslAstBuildPtr -> Ptr () -> Ptr () -> IO IslAstBuildPtr

foreign import capi "isl/ast_build.h isl_ast_build_alloc" c_isl_ast_build_alloc
  :: IslCtxPtr -> IO IslAstBuildPtr

foreign import capi "isl/ast_build.h isl_ast_build_node_from_schedule" c_isl_ast_build_node_from_schedule
  :: IslAstBuildPtr -> IslSchedulePtr -> IO IslAstNodePtr

-- Haskell wrappers
islAstBuildFromSchedule :: IslAstBuildPtr -> IslSchedulePtr -> IO IslAstNodePtr
islAstBuildFromSchedule = c_isl_ast_build_ast_from_schedule

islAstBuildSetAtEachDomain :: IslAstBuildPtr -> Ptr () -> Ptr () -> IO IslAstBuildPtr
islAstBuildSetAtEachDomain = c_isl_ast_build_set_at_each_domain 

islAstBuildAlloc :: IslCtxPtr -> IO IslAstBuildPtr
islAstBuildAlloc = c_isl_ast_build_alloc

islAstBuildNodeFromSchedule :: IslAstBuildPtr -> IslSchedulePtr -> IO IslAstNodePtr
islAstBuildNodeFromSchedule = c_isl_ast_build_node_from_schedule
