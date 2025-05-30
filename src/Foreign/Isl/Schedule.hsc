{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE CApiFFI #-}
{-# LANGUAGE EmptyDataDecls #-}

module Foreign.Isl.Schedule
  ( IslScheduleConstraints
  , IslScheduleConstraintsPtr
  , IslSchedule
  , IslSchedulePtr
  , islScheduleConstraintsOnDomain
  , islScheduleConstraintsSetValidity
  , islScheduleConstraintsComputeSchedule
  , islScheduleFromDomain
  , islPrinterPrintSchedule
  ) where

import Foreign.Ptr
import Foreign.Isl.UnionMap
import Foreign.Isl.UnionSet
import Foreign.Isl.PrinterTypes

#include <isl/schedule.h>

-- | The ISL schedule constraints structure
data IslScheduleConstraints

type IslScheduleConstraintsPtr = Ptr IslScheduleConstraints

-- | The ISL schedule structure
data IslSchedule

type IslSchedulePtr = Ptr IslSchedule

-- | Create schedule constraints on a domain
foreign import capi "isl/schedule.h isl_schedule_constraints_on_domain" c_isl_schedule_constraints_on_domain
  :: IslUnionSetPtr -> IO IslScheduleConstraintsPtr

-- | Set validity for schedule constraints
foreign import capi "isl/schedule.h isl_schedule_constraints_set_validity" c_isl_schedule_constraints_set_validity
  :: IslScheduleConstraintsPtr -> IslUnionMapPtr -> IO IslScheduleConstraintsPtr

-- | Compute a schedule from constraints
foreign import capi "isl/schedule.h isl_schedule_constraints_compute_schedule" c_isl_schedule_constraints_compute_schedule
  :: IslScheduleConstraintsPtr -> IO IslSchedulePtr

foreign import capi "isl/schedule.h isl_schedule_from_domain" c_isl_schedule_from_domain
  :: IslUnionSetPtr -> IO IslSchedulePtr
  
foreign import capi "isl/schedule.h isl_printer_print_schedule"
  c_isl_printer_print_schedule
  :: IslPrinterPtr -> IslSchedulePtr -> IO IslPrinterPtr

-- Haskell wrappers
islScheduleConstraintsOnDomain :: IslUnionSetPtr -> IO IslScheduleConstraintsPtr
islScheduleConstraintsOnDomain = c_isl_schedule_constraints_on_domain

islScheduleConstraintsSetValidity :: IslScheduleConstraintsPtr -> IslUnionMapPtr -> IO IslScheduleConstraintsPtr
islScheduleConstraintsSetValidity = c_isl_schedule_constraints_set_validity

islScheduleConstraintsComputeSchedule :: IslScheduleConstraintsPtr -> IO IslSchedulePtr
islScheduleConstraintsComputeSchedule = c_isl_schedule_constraints_compute_schedule 

islScheduleFromDomain :: IslUnionSetPtr -> IO IslSchedulePtr
islScheduleFromDomain = c_isl_schedule_from_domain

islPrinterPrintSchedule :: IslPrinterPtr -> IslSchedulePtr -> IO IslPrinterPtr
islPrinterPrintSchedule = c_isl_printer_print_schedule


