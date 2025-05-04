module Isl.DimType
  ( DimType (..),
    dimTypeToInt,
  )
where

data DimType
  = DimIn
  | DimOut
  | DimSet
  | DimDiv
  | DimCst
  deriving (Eq, Ord, Show)

dimTypeToInt :: DimType -> Int
dimTypeToInt DimIn = 0
dimTypeToInt DimOut = 1
dimTypeToInt DimSet = 2
dimTypeToInt DimDiv = 3
dimTypeToInt DimCst = 4
