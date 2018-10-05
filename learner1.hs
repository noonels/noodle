{-
  Programmer: Matthew Healy <mhrh3@mst.edu>
      Course: CS5001 Deep Learning
  Assignment: HW #1, Linear Regression Learner
   Professor: Dr. Ricardo Morales
-}
import System.Random
import System.IO
import Data.List
import Data.Char

sumSquareError :: (Num a) => a -> a -> [(a, a)] -> a
sumSquareError w0 w1 [es] =
  sum [ ( ( snd e ) - ( yHat w0 w1 e ) )^2 | e <- es ]

yHat :: (Num a) => [a] -> [a] -> a
yHat ws xs = let xs' =
  sum $ [(ws !! i) * (xs !! i) | i <- [1..(len xs)]]

linError :: (Num a) => [a] -> ([a] -> a) -> a
linError ws (xs y) = y - (yHat ws xs)

learn :: (Num a) => [a] -> [a] -> a -> [a]
learn weights examples eta =
  learn' weights examples eta 5000
  where learn' ws es eta count
          | count == 0 = ws
          | otherwise = let s = len xs in
            [(ws !! i) + eta * (linError ws es !! i) * (es !! i) | i <- [1..s]]

getExamples :: String -> [([Num], Num)]
getExamples s =
  getExamples' (splitOn "\n" s) []
  where getExamples' s es
          | s == [] = es
          | otherwise =
            let
              (xString, yString) 
            in
              [(xs, y)] ++ getExamples' (tail s) es



main = do
  contents <- readFile "trash.txt"
  es = getExamples contents
  seed = --wat now???
  eta = 2 -- arbitrarily pick learning rate
  g <- getStdGen
  ws = take 2 $ randomRs (0, 100) g -- initialize weights
  ws' = learn ws es eta
  sse = sumSquareError ws' es
  hdr = ("CS-5001: HW#1 \nProgrammer: Matthew Healy <mhrh3>\n\n"
  ++ "TRAINING\n"
  ++ "Using random seed = " ++ (show seed) ++ "\n"
  ++ "Using learning rate eta = " ++ (show eta) ++ "\n"
  ++ "After 5000 iterations:\n"
  ++ "Weights:\n"
  ++ "w0 = " ++ (show ws' !! 0) ++ "\n"
  ++ "w1 = " ++ (show ws' !! 1) ++ "\n"
  ++ "\n"
  ++ "VALIDATION\n"
  ++ "Sum-of-Squares Error = " ++ (show sse))
  putStrLn hdr