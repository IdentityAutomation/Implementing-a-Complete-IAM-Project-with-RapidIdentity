UPDATE ingest_raw r
SET r.operationFlags=r.operationFlags | 2
WHERE 
	r.affiliation = '%affiliation%'
	AND r.objectId NOT IN
		(
			SELECT affiliations->>'$.%affiliation%.id' 
			FROM master_live as m
			WHERE m.affiliations->>'$.%affiliation%.id' = r.objectId
		)
	AND 
		(
			r.object->>'$.nationalId' IN
			(
				SELECT m.affiliations->>'$.employees.nationalId' 
				FROM master_live as m
				WHERE m.affiliations->>'$.employees.nationalId' = r.object->>'$.nationalId'
			)
			OR r.object->>'$.nationalId' IN
			(
				SELECT m.affiliations->>'$.students.nationalId' 
				FROM master_live as m
				WHERE m.affiliations->>'$.students.nationalId' = r.object->>'$.nationalId'
			)
			OR
		    (
		        r.affiliation='professors'
			    AND
			    (
			        r.objectId IN
        			(
        				SELECT m.affiliations->>'$.employees.id' 
        				FROM master_live as m
        				WHERE m.affiliations->>'$.employees.id' = r.objectId
        			)
			    )
		    )
		)
