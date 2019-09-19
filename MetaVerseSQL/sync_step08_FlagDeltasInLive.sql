UPDATE ingest_raw r
LEFT OUTER JOIN ingest_live l ON 
	r.objectId = l.objectId
	AND l.affiliation = r.affiliation
SET r.operationFlags=r.operationFlags | 8
WHERE 
    r.affiliation='%affiliation%'
    AND IFNULL(l.object,'') != IFNULL(r.object,'')