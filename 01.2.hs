readInt = read :: String -> Int

derive l = map
  (uncurry (-))
  (zip
    (tail l)
    l)

slide3 l = zip3
  (drop 2 l)
  (drop 1 l)
  l

main = do
  contents <- readFile "01.input"
  print
    $ length
    $ filter (> 0)
    $ derive
    $ map (\(x,y,z) -> x + y + z)
    $ slide3
    $ map readInt
    $ lines contents
