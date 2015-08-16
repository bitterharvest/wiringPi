{--
This is a test program for LED. 

Compile: ghc TestLed.hs -lwiringPi -lpthread
Aug. 17, 2015
--}

import WiringHs
import System.IO
import Control.Concurrent.Thread.Delay
import Control.Monad

pin = 4

main = do
  r <- wiringPiSetupGpio
  if (r == -1) 
    then putStrLn "Error"
    else do
      pinMode pin output
      forM [1..10] $ \i -> do
        digitalWrite pin 0
        delay 950000
        digitalWrite pin 1 
        delay 50000
      putStrLn "End"
      digitalWrite pin 0
