{-# LANGUAGE ForeignFunctionInterface #-}
module WiringHs where

import Foreign.C -- get the C types

--AUTHOR : Kenji Ohmori
--DATE   : Aug 16 2015

-- Handy defines

-- Deprecated
num_pins = 17 :: Int

wpi_mode_pins =  0 :: Int
wpi_mode_gpio =  1 :: Int
wpi_mode_gpio_sys =  2 :: Int
wpi_mode_phys =  3 :: Int
wpi_mode_piface =  4 :: Int
wpi_mode_uninitialised = -1 :: Int

-- Pin modes

input =  0 :: Int
output =  1 :: Int
pwm_output =  2 :: Int
gpio_clock =  3 :: Int
soft_pwm_output =  4 :: Int
soft_tone_output =  5 :: Int
pwm_tone_output =  6 :: Int

low = 	 0 :: Int
high =  1 :: Int
-- Pull up/down/none

pud_off =  0 :: Int
pud_down =  1 :: Int
pud_up =  2 :: Int

-- PWM

pwm_mode_ms = 0 :: Int
pwm_mode_bal = 1 :: Int

-- Interrupt levels

int_edge_setup = 0 :: Int
int_edge_falling = 1 :: Int
int_edge_rising = 2 :: Int
int_edge_both = 3 :: Int

-- Pi model types and version numbers
--	Intended for the GPIO program Use at your own risk.

pi_model_unknown = 0 :: Int
pi_model_a = 	1 :: Int
pi_model_b = 	2 :: Int
pi_model_bp = 3 :: Int
pi_model_cm = 4 :: Int
pi_model_ap = 5 :: Int
pi_model_2 = 	6 :: Int

pi_version_unknown = 0 :: Int
pi_version_1 = 1 :: Int
pi_version_1_1 = 2 :: Int
pi_version_1_2 = 3 :: Int
pi_version_2 = 4 :: Int

pi_maker_unknown = 0 :: Int
pi_maker_egoman = 	1 :: Int
pi_maker_sony = 2 :: Int
pi_maker_qisda = 3 :: Int
pi_maker_mbest = 4 :: Int

--extern const char *piModelNames    [7] ;
--extern const char *piRevisionNames [5] ;
--extern const char *piMakerNames    [5] ;


--	Intended for the GPIO program Use at your own risk.

-- Threads

-- #define	PI_THREAD(X)	void *X (void *dummy)

-- Failure modes

-- #define	WPI_FATAL	(1==1)
-- #define	WPI_ALMOST	(1==2)

-- wiringPiNodeStruct:
--	This describes additional device nodes in the extended wiringPi
--	2.0 scheme of things.
--	It's a simple linked list for now, but will hopefully migrate to 
--	a binary tree for efficiency reasons - but then again, the chances
--	of more than 1 or 2 devices being added are fairly slim, so who
--	knows....

{--
struct wiringPiNodeStruct
{
  int     pinBase ;
  int     pinMax ;

  int          fd ;	-- Node specific
  unsigned int data0 ;	--  ditto
  unsigned int data1 ;	--  ditto
  unsigned int data2 ;	--  ditto
  unsigned int data3 ;	--  ditto

  void   (*pinMode)         (struct wiringPiNodeStruct *node, int pin, int mode) ;
  void   (*pullUpDnControl) (struct wiringPiNodeStruct *node, int pin, int mode) ;
  int    (*digitalRead)     (struct wiringPiNodeStruct *node, int pin) ;
  void   (*digitalWrite)    (struct wiringPiNodeStruct *node, int pin, int value) ;
  void   (*pwmWrite)        (struct wiringPiNodeStruct *node, int pin, int value) ;
  int    (*analogRead)      (struct wiringPiNodeStruct *node, int pin) ;
  void   (*analogWrite)     (struct wiringPiNodeStruct *node, int pin, int value) ;

  struct wiringPiNodeStruct *next ;
} ;

extern struct wiringPiNodeStruct *wiringPiNodes ;
--}


-- Data

-- Internal

--extern int wiringPiFailure (int fatal, const char *message, ...) ;

-- Core wiringPi functions

--extern struct wiringPiNodeStruct *wiringPiFindNode (int pin) ;
--extern struct wiringPiNodeStruct *wiringPiNewNode  (int pinBase, int numPins) ;

foreign import ccall"wiring.h wiringPiSetup" c_wiringPiSetup :: IO CInt
wiringPiSetup :: IO Int
wiringPiSetup = fmap fromIntegral $ c_wiringPiSetup 

foreign import ccall"wiring.h wiringPiSetupSys" c_wiringPiSetupSys :: IO CInt
wiringPiSetupSys :: IO Int
wiringPiSetupSys = fmap fromIntegral $ c_wiringPiSetupSys 

foreign import ccall"wiring.h wiringPiSetupGpio" c_wiringPiSetupGpio :: IO CInt
wiringPiSetupGpio :: IO Int
wiringPiSetupGpio = fmap fromIntegral $ c_wiringPiSetupGpio 

foreign import ccall"wiring.h wiringPiSetupPhys" c_wiringPiSetupPhys :: IO CInt
wiringPiSetupPhys :: IO Int
wiringPiSetupPhys = fmap fromIntegral $ c_wiringPiSetupPhys 

foreign import ccall"wiring.h pinModeAlt" c_pinModeAlt :: CInt -> CInt -> IO ()
pinModeAlt :: Int -> Int -> IO ()
pinModeAlt pin mode = c_pinModeAlt (fromIntegral pin) (fromIntegral mode)

foreign import ccall"wiring.h pinMode" c_pinMode :: CInt -> CInt -> IO ()
pinMode :: Int -> Int -> IO ()
pinMode pin mode = c_pinMode (fromIntegral pin) (fromIntegral mode)

foreign import ccall"wiring.h pullUpDnControl " c_pullUpDnControl :: CInt -> CInt -> IO ()
pullUpDnControl :: Int -> Int -> IO ()
pullUpDnControl pin pud = c_pullUpDnControl (fromIntegral pin) (fromIntegral pud)

foreign import ccall"wiring.h digitalRead" c_digitalRead :: CInt -> IO CInt
digitalRead :: Int -> IO Int
digitalRead pin = fmap fromIntegral $ c_digitalRead (fromIntegral pin)

foreign import ccall"wiring.h digitalWrite" c_digitalWrite :: CInt -> CInt -> IO () 
digitalWrite :: Int -> Int -> IO ()
digitalWrite pin value = c_digitalWrite (fromIntegral pin) (fromIntegral value)

foreign import ccall"wiring.h pwmWrite" c_pwmWrite :: CInt -> CInt -> IO ()
pwmWrite :: Int -> Int -> IO ()
pwmWrite pin value = c_pwmWrite (fromIntegral pin) (fromIntegral value)

foreign import ccall"wiring.h analogRead" c_analogRead :: CInt -> IO CInt
analogRead :: Int -> IO Int
analogRead pin = fmap fromIntegral $ c_analogRead (fromIntegral pin)

foreign import ccall"wiring.h analogWrite" c_analogWrite :: CInt -> CInt -> IO ()
analogWrite :: Int -> Int -> IO ()
analogWrite pin value = c_analogWrite (fromIntegral pin) (fromIntegral value)

-- PiFace specifics 
--	(Deprecated)

--extern int  wiringPiSetupPiFace (void) ;
--extern int  wiringPiSetupPiFaceForGpioProg (void) ;	// Don't use this - for gpio program only

-- On-Board Raspberry Pi hardware specific stuff

foreign import ccall"wiring.h piBoardRev" c_piBoardRev :: IO CInt
piBoardRev :: IO Int
piBoardRev = fmap fromIntegral $ c_piBoardRev 

--extern void piBoardId           (int *model, int *rev, int *mem, int *maker, int *overVolted) ;

foreign import ccall"wiring.h wpiPinToGpio" c_wpiPinToGpio :: CInt -> IO CInt 
wpiPinToGpio :: Int -> IO Int
wpiPinToGpio wpiPin = fmap fromIntegral $ c_wpiPinToGpio (fromIntegral wpiPin)

foreign import ccall"wiring.h physPinToGpio" c_physPinToGpio :: CInt -> IO CInt
physPinToGpio :: Int -> IO Int
physPinToGpio physPin = fmap fromIntegral $ c_physPinToGpio (fromIntegral physPin) 

foreign import ccall"wiring.h setPadDrive" c_setPadDrive :: CInt -> CInt -> IO ()
setPadDrive :: Int -> Int -> IO ()
setPadDrive group value = c_setPadDrive (fromIntegral group) (fromIntegral value)

foreign import ccall"wiring.h getAlt" c_getAlt :: CInt -> IO CInt
getAlt :: Int -> IO Int
getAlt pin = fmap fromIntegral $ c_getAlt (fromIntegral pin)

foreign import ccall"wiring.h pwmToneWrite" c_pwmToneWrite :: CInt -> CInt -> IO ()
pwmToneWrite :: Int -> Int -> IO ()
pwmToneWrite pin freq = c_pwmToneWrite (fromIntegral pin) (fromIntegral freq)

foreign import ccall"wiring.h digitalWriteByte" c_digitalWriteByte :: CInt -> IO ()
digitalWriteByte :: Int -> IO ()
digitalWriteByte value = c_digitalWriteByte (fromIntegral value)

foreign import ccall"wiring.h pwmSetMode" c_pwmSetMode :: CInt -> IO ()
pwmSetMode :: Int -> IO ()
pwmSetMode mode = c_pwmSetMode (fromIntegral mode)

foreign import ccall"wiring.h pwmSetRange" c_pwmSetRange :: CUInt -> IO ()
pwmSetRange :: Int -> IO ()
pwmSetRange range = c_pwmSetRange (fromIntegral range)

foreign import ccall"wiring.h pwmSetClock" c_pwmSetClock :: CInt -> IO () 
pwmSetClock :: Int -> IO ()
pwmSetClock divisor = c_pwmSetClock (fromIntegral divisor)

foreign import ccall"wiring.h gpioClockSet" c_gpioClockSet :: CInt -> CInt -> IO ()
gpioClockSet :: Int -> Int -> IO ()
gpioClockSet pin freq = c_gpioClockSet (fromIntegral pin) (fromIntegral freq)

-- Interrupts
--	(Also Pi hardware specific)

--extern int  waitForInterrupt    (int pin, int mS) ;
--extern int  wiringPiISR         (int pin, int mode, void (*function)(void)) ;

-- Threads

--extern int  piThreadCreate      (void *(*fn)(void *)) ;
--extern void piLock              (int key) ;
--extern void piUnlock            (int key) ;

-- Schedulling priority

--extern int piHiPri (const int pri) ;

-- Extras from arduino land

--extern void         delay             (unsigned int howLong) ;
--extern void         delayMicroseconds (unsigned int howLong) ;
--extern unsigned int millis            (void) ;
--extern unsigned int micros            (void) ;

