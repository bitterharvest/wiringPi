This program is a Haskell service wrapper for users who want to implement application programs of Raspberry Pi with motors and sensors through gpio interface using functional programming language Haskell.　

WiringHs is a collection of foreign function interfaces which enables a Haskell program to use the libraries of WiringPi, which is described at http://wiringpi.com/.

A simple example that turns on and off an LED.
The program is compiled by

ghc TestLed.hs -lwiringPi -lpthread
