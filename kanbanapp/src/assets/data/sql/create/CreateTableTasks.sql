CREATE TABLE main.tasks
(
	taskId INTEGER PRIMARY KEY AUTOINCREMENT,
	name String NOT NULL,
	description String,
    statusId INTEGER,
	FOREIGN KEY(statusId) REFERENCES statuses(statusId)
)