DELETE FROM ingest_raw 
WHERE 
	affiliation = '%affiliation%' AND
	errorFlag != 0