SELECT
    id,
    affiliations->>'$' AS affiliations,
    insertedAt,
    updatedAt
FROM master_live
ORDER BY %sort% %sortOrder%
LIMIT %offset%, %limit%