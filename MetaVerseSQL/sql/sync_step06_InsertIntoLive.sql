INSERT IGNORE INTO ingest_live 
	(
		masterLiveId,
		affiliation,
		objectId,
		object,
		createdAt,
		updatedAt
	)
	SELECT 
		m.id,
		'%affiliation%',
		r.objectId,
		r.object,
		CURTIME(),
		CURTIME()
	FROM ingest_raw r
	LEFT JOIN master_live AS m ON 
		m.affiliations->>'$.%affiliation%.id' = r.objectId
	WHERE 
		r.affiliation = '%affiliation%' AND
		(operationFlags & 4)=4
