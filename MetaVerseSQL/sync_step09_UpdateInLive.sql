UPDATE ingest_live l 
INNER JOIN ingest_raw r ON 
    l.objectId=r.objectId
    AND r.affiliation=l.affiliation
SET l.object=r.object
WHERE 
    r.affiliation='%affiliation%'
    AND (r.operationFlags & 8)=8