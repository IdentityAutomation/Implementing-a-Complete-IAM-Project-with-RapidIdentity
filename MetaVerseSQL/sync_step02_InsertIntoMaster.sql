INSERT INTO master_live (affiliations, insertedAt, updatedAt) 
	SELECT 
		JSON_OBJECT(
			'%affiliation%',
			JSON_OBJECT(
				'status',object->>'$.status', 
				'id', object->>'$.id',
				'nationalId', object->>'$.nationalId'
			)
		), 
		CURTIME(), 
		CURTIME()
	FROM ingest_raw
	WHERE affiliation='%affiliation%' and operationFlags=1