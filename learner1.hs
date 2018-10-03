{-
PROCEDURE Incremental_Linear_Learner
GIVEN:
E[0..n] : examples, each a <x, y> pair
eta : the learning rate
LOCAL:
    w[0,1] : weights
Randomize w[0], w[1].
REPEAT 5000 times
    FOR k := 0 to n DO                        // go through examples
        Compute yCap ( from w[0], w[1] and E[k] ) 
        error :=  Ex[k].y - yCap
        FOR each weight w[i]
w[i] := w[i]  +  eta * error * E[k].x[i] 
         return w[]
-}

updateWeight :: Num -> Num -> Num -> Num -> Num
updateWeight wi eta err xi =
  wi + eta * err * xi

updateWeights :: [Num] -> [Num]
updateWeights = map updateWeight

computeYHat :: Num -> Num -> (Num, Num) -> Num
computeYHat w0 w1 (x, y) = undefined

computeError :: Num -> Num -> Num
computeError y yh = y - yh

learn :: [(Num, Num)] -> Num -> (Num, Num)
learn examples eta =
  go examples eta w0 w1 5000
  where 
    w0 = rand 0 100
    w1 = rand 0 100
    go ex eta w0 w1 count
          | count <= 0 = (w0, w1)
          | otherwise =
            let
              yh = [computeYHat w0 w1 x | x <- ex]
              err = [computeError (snd (ex !! i)) (yh !! i) | i <- [1..(len ex)] ]
            in
              go ex eta (updateWeights ws) (count - 1)

main = do
  let
    eta = 2
    (w0, w1) = learn examples eta
    yh = [computeYHat w0 w1 x | x <- examples]
    totalError = sum [(examples !! i) - (yh !! i) | i <- [1..(len examples)]]
    hdr = ("CS-5001: HW#1 \nProgrammer: Matthew Healy <mhrh3>\n\n"
    ++ "TRAINING\n"
    ++ "Using random seed = " ++ (show seed) ++ "\n"
    ++ "Using learning rate eta = " ++ (show eta) ++ "\n"
    ++ "After 5000 iterations:\n"
    ++ "Weights:\n"
    ++ "w0 = " ++ (show w0) ++ "\n"
    ++ "w1 = " ++ (show w1) ++ "\n"
    ++ "\n"
    ++ "VALIDATION\n"
    ++ "Sum-of-Squares Error = " ++ (show totalError))
  putStrLn $ hdr
