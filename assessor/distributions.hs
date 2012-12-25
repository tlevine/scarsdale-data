-- Retrieve only the taxable values for each house; retrieving identifying
-- fields would be more work, so don't worry about them for now.

taxable="(COUNTY|VILLAGE|SCHOOL) TAXABLE ([0-9,]+)"
