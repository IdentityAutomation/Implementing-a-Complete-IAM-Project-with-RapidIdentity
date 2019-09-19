UPDATE ingest_raw e
SET errorFlag = 1
WHERE
	affiliation='employees' AND
	(
		e.object->>'$.id' IS NULL OR
		e.object->>'$.id' NOT REGEXP '^[a-zA-Z0-9]{8}$' OR
		e.object->>'$.firstName' IS NULL OR
		e.object->>'$.firstName' NOT REGEXP '^[a-zA-Z]{2,}$' OR
		e.object->>'$.lastName' IS NULL OR
		e.object->>'$.lastName' NOT REGEXP '^[a-zA-Z \'\.\-]{2,}$' OR
		e.object->>'$.positionCode' IS NULL OR
		e.object->>'$.positionCode' NOT REGEXP '^[0-9]{4}$' OR
		e.object->>'$.departmentCode' IS NULL OR
		e.object->>'$.departmentCode' NOT REGEXP '^[0-9]{4}$' OR
		e.object->>'$.locationCode' IS NULL OR
		e.object->>'$.locationCode' NOT REGEXP '^[0-9]{4}$' OR
		e.object->>'$.managerId' IS NULL OR
		e.object->>'$.managerId' NOT REGEXP '^[a-zA-Z0-9]{8}$' OR
		e.object->>'$.personalEmail' IS NULL OR
		e.object->>'$.dateOfBirth' IS NULL OR
		e.object->>'$.dateOfBirth' NOT REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$' OR
		e.object->>'$.nationalId' IS NULL OR
		e.object->>'$.nationalId' NOT REGEXP '^[0-9]{3}-[0-9]{2}-[0-9]{4}$' OR
		e.object->>'$.status' IS NULL OR
		e.object->>'$.status' NOT REGEXP '^A|I$'
	)
