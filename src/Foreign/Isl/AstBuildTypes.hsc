{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.AstBuildTypes
  ( IslAstBuild
  , IslAstBuildPtr
  , IslAstNode
  , IslAstNodePtr
  ) where

#include <isl/ast_build.h>
#include <isl/ast.h>

import Foreign.Ptr

-- | The ISL ast build structure
data IslAstBuild

type IslAstBuildPtr = Ptr IslAstBuild

-- | The ISL ast node structure
data IslAstNode

type IslAstNodePtr = Ptr IslAstNode
