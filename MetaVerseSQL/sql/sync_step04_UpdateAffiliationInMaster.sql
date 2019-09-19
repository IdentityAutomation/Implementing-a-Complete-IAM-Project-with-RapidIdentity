UPDATE master_live m
INNER JOIN ingest_raw r ON 
    m.affiliations->>'$.employees.nationalId' = r.object->>'$.nationalId'
    OR m.affiliations->>'$.students.nationalId' = r.object->>'$.nationalId'
    OR
    (
        r.affiliation='professors'
        AND m.affiliations->>'$.employees.id' = r.objectId
    )
SET m.affiliations = JSON_SET(
	m.affiliations,
	'$.%affiliation%', 
	JSON_OBJECT(
		'id', r.objectId, 
		'status', r.object->>'$.status', 
		'nationalId', r.object->>'$.nationalId'
	)
)
WHERE 
	r.affiliation = '%affiliation%'
	AND (r.operationFlags & 2)=2
