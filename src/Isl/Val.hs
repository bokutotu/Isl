module Isl.Val
  ( Val (..),
    zero,
    one,
    negone,
    nan,
    infty,
    neginfty,
    intFromSi,
    intFromUi,
    readFromStr,
    sgn,
    isZero,
    isOne,
    isNegone,
    isNan,
    isInfty,
    isNeginfty,
    eq,
    ne,
    lt,
    gt,
    le,
    ge,
    add,
    sub,
    mul,
    divide,
    toStr,
  )
where

import Foreign.C.String (peekCString)
import Foreign.Isl.Val
import Isl.Ctx (Ctx (..))
import System.IO.Unsafe (unsafePerformIO)

newtype Val = Val {unVal :: IslValPtr}

zero, one, negone, nan, infty, neginfty :: Ctx -> Maybe Val
zero (Ctx ctx) = Just $ Val $ unsafePerformIO $ islValZero ctx
one (Ctx ctx) = Just $ Val $ unsafePerformIO $ islValOne ctx
negone (Ctx ctx) = Just $ Val $ unsafePerformIO $ islValNegone ctx
nan (Ctx ctx) = Just $ Val $ unsafePerformIO $ islValNan ctx
infty (Ctx ctx) = Just $ Val $ unsafePerformIO $ islValInfty ctx
neginfty (Ctx ctx) = Just $ Val $ unsafePerformIO $ islValNeginfty ctx

intFromSi :: Ctx -> Integer -> Maybe Val
intFromSi (Ctx ctx) i = Just $ Val $ unsafePerformIO $ islValIntFromSi ctx (fromIntegral i)

intFromUi :: Ctx -> Integer -> Maybe Val
intFromUi (Ctx ctx) i = Just $ Val $ unsafePerformIO $ islValIntFromUi ctx (fromIntegral i)

readFromStr :: Ctx -> String -> Maybe Val
readFromStr (Ctx ctx) str = Just $ Val $ unsafePerformIO $ islValReadFromStr ctx str

sgn :: Val -> Int
sgn (Val v) = fromIntegral $ unsafePerformIO $ islValSgn v

isZero, isOne, isNegone, isNan, isInfty, isNeginfty :: Val -> Bool
isZero (Val v) = unsafePerformIO (islValIsZero v) /= 0
isOne (Val v) = unsafePerformIO (islValIsOne v) /= 0
isNegone (Val v) = unsafePerformIO (islValIsNegone v) /= 0
isNan (Val v) = unsafePerformIO (islValIsNan v) /= 0
isInfty (Val v) = unsafePerformIO (islValIsInfty v) /= 0
isNeginfty (Val v) = unsafePerformIO (islValIsNeginfty v) /= 0

eq, ne, lt, gt, le, ge :: Val -> Val -> Bool
eq (Val v1) (Val v2) = unsafePerformIO (islValEq v1 v2) /= 0
ne (Val v1) (Val v2) = unsafePerformIO (islValNe v1 v2) /= 0
lt (Val v1) (Val v2) = unsafePerformIO (islValLt v1 v2) /= 0
gt (Val v1) (Val v2) = unsafePerformIO (islValGt v1 v2) /= 0
le (Val v1) (Val v2) = unsafePerformIO (islValLe v1 v2) /= 0
ge (Val v1) (Val v2) = unsafePerformIO (islValGe v1 v2) /= 0

add, sub, mul, divide :: Val -> Val -> Maybe Val
add (Val v1) (Val v2) = Just $ Val $ unsafePerformIO $ islValAdd v1 v2
sub (Val v1) (Val v2) = Just $ Val $ unsafePerformIO $ islValSub v1 v2
mul (Val v1) (Val v2) = Just $ Val $ unsafePerformIO $ islValMul v1 v2
divide (Val v1) (Val v2) = Just $ Val $ unsafePerformIO $ islValDiv v1 v2

toStr :: Val -> String
toStr (Val v) = unsafePerformIO $ islValToStr v >>= peekCString
