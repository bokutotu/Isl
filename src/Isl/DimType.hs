module Isl.DimType
  ( DimType (..),
    dimTypeToInt,
  )
where

data DimType = DimCst
             | DimParam
             | DimIn
             | DimOut
             | DimSet
             | DimDiv
             | DimAll
  deriving (Eq, Ord, Show)

dimTypeToInt :: DimType -> Int
dimTypeToInt DimCst   = 0
dimTypeToInt DimParam = 1
dimTypeToInt DimIn    = 2
dimTypeToInt DimOut   = 3
dimTypeToInt DimSet   = 3
dimTypeToInt DimDiv   = 4
dimTypeToInt DimAll   = 5
