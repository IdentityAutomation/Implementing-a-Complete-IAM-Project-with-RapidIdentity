UPDATE ingest_raw SET operationFlags=operationFlags | 4
	WHERE affiliation = '%affiliation%'
		AND objectId NOT IN
			(SELECT objectId FROM ingest_live WHERE affiliation = '%affiliation%')
