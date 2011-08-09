SELECT taskId,
	name,
	description,
	statusId
FROM main.tasks
WHERE taskId = :taskId