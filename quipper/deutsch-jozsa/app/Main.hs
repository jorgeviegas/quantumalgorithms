module Main where

import Lib
import Quipper

main :: IO ()
main = print_simple Preview (hello_world True)
