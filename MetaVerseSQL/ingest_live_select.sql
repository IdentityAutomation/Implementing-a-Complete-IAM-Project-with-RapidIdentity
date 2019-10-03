SELECT 
    masterLiveId as entityId,
    object->>'$' AS object,
    insertedAt,
    updatedAt
FROM ingest_live 
WHERE affiliation='%affiliation%'
    AND objectId='%objectId%'