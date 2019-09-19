INSERT IGNORE INTO event_log
	(
		masterLiveId,
		affiliation,
		objectId,
		createdAt,
		status
	)
	SELECT 
		m.id,
		'%affiliation%',
		r.objectId,
		CURTIME(),
		'A'
	FROM ingest_raw r
	LEFT JOIN master_live AS m ON 
		m.affiliations->>'$.%affiliation%.id' = r.objectId
	WHERE 
		r.affiliation = '%affiliation%' AND
		(operationFlags & 4)=4
