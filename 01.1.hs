readInt = read :: String -> Int

derive l = map
  (uncurry (-))
  (zip
    (tail l)
    l)

main = do
  contents <- readFile "01.input"
  print
    $ length
    $ filter (> 0)
    $ derive
    $ map readInt
    $ lines contents
