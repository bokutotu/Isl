module Isl.Schedule
  ( ScheduleConstraints (..),
    Schedule (..),
    constraintsOnDomain,
    setValidity,
    computeSchedule,
  )
where

import Foreign.Isl.Schedule
import Isl.UnionMap (UnionMap (..))
import Isl.UnionSet (UnionSet (..))
import System.IO.Unsafe (unsafePerformIO)

-- | A safe wrapper around IslScheduleConstraints
newtype ScheduleConstraints = ScheduleConstraints {unScheduleConstraints :: IslScheduleConstraintsPtr}

-- | A safe wrapper around IslSchedule
newtype Schedule = Schedule {unSchedule :: IslSchedulePtr}

-- | Create schedule constraints on a domain
constraintsOnDomain :: UnionSet -> Maybe ScheduleConstraints
constraintsOnDomain (UnionSet ptr) =
  Just $ ScheduleConstraints $ unsafePerformIO $ islScheduleConstraintsOnDomain ptr

-- | Set validity for schedule constraints
setValidity :: ScheduleConstraints -> UnionMap -> Maybe ScheduleConstraints
setValidity (ScheduleConstraints sc) (UnionMap um) =
  Just $ ScheduleConstraints $ unsafePerformIO $ islScheduleConstraintsSetValidity sc um

-- | Compute a schedule from constraints
computeSchedule :: ScheduleConstraints -> Maybe Schedule
computeSchedule (ScheduleConstraints sc) =
  Just $ Schedule $ unsafePerformIO $ islScheduleConstraintsComputeSchedule sc
