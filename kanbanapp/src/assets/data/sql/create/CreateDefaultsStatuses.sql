INSERT INTO main.statuses (statusId, label, taskLimit)
SELECT 1, 'Backlog', 0 UNION
SELECT 2, 'Doing', 3 UNION
SELECT 3, 'Done', 0