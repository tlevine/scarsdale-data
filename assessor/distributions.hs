-- Retrieve only the taxable values for each house; retrieving identifying
-- fields would be more work, so don't worry about them for now.

import Text.Regex.Posix
import Data.List.Split
import Data.String.Utils

retrieve :: String -> [String]
retrieve line = getAllTextMatches $ line =~ "(COUNTY|VILLAGE|SCHOOL) TAXABLE ([0-9,]+)" :: [String]

parse :: String -> (String, Int)
parse snip = (tax, assessed)
  where
    components = splitOn " TAXABLE " snip
    tax = head components
    assessed = read (replace "," "" (last components)) :: Int

main = do
  line <- getLine
  putStrLn $ show $ retrieve line
  putStrLn $ show $ fmap parse $ retrieve line
