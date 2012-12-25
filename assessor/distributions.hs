-- Retrieve only the taxable values for each house; retrieving identifying
-- fields would be more work, so don't worry about them for now.

import Text.Regex.Posix

--line = "COUNTY TAXABLE 19,800 48 WALWORTH AVE. ACREAGE 0.55 VILLAGE TAXABLE 19,800"

taxable :: String -> [String]
taxable line = getAllTextMatches $ line =~ "(COUNTY|VILLAGE|SCHOOL) TAXABLE ([0-9,]+)" :: [String]

main = do
  line <- getLine
  putStrLn $ show $ taxable line
