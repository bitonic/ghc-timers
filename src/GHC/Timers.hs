-- | Stopping alarms is sometimes necessary when dealing with foreign
-- code that need to run long-running blocking syscalls. This is the
-- same problem described in <https://ghc.haskell.org/trac/ghc/ticket/4074>.
-- To reliably stop alarms we use the RTS own functions, as to not
-- be overrulen or overrule the RTS. See comment in rts/Timers.c:
--
-- This global counter is used to allow multiple threads to stop the
-- timer temporarily with a stopTimer()/startTimer() pair.  If
--      timer_enabled  == 0          timer is enabled
--      timer_disabled == N, N > 0   timer is disabled by N threads
-- When timer_enabled makes a transition to 0, we enable the timer,
-- and when it makes a transition to non-0 we disable it.
module GHC.Timers
  ( startTimer
  , stopTimer
  , rtsTimerSignal
  ) where

import Foreign.C.Types (CInt(..))

foreign import ccall unsafe "startTimer" startTimer :: IO ()
foreign import ccall unsafe "stopTimer" stopTimer :: IO ()
foreign import ccall unsafe "rtsTimerSignal" rtsTimerSignal :: IO CInt
