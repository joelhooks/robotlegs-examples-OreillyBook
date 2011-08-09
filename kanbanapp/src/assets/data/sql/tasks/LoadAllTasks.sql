SELECT taskId,
	name,
	description,
	statusId
FROM main.tasks
ORDER BY statusId COLLATE NOCASE