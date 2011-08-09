package robotlegs.examples.kanban.service
{
    import com.probertson.data.QueuedStatement;

    import flash.data.SQLResult;
    import flash.errors.SQLError;

    import org.robotlegs.mvcs.Actor;

    import robotlegs.examples.kanban.controller.events.DatabaseErrorHandlerEvent;
    import robotlegs.examples.kanban.model.StatusListModel;
    import robotlegs.examples.kanban.model.TaskListModel;
    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.model.vo.Task;
    import robotlegs.examples.kanban.service.helpers.ISQLRunnerDelegate;

    public class SQLTaskService extends Actor implements ITaskService
    {
        [Inject]
        public var sqlRunner:ISQLRunnerDelegate;

        [Inject]
        public var statusListModel:StatusListModel;

        [Inject]
        public var taskListModel:TaskListModel;

        public function loadAllTasks():void
        {
            statusListModel.removeAllTasks();
            sqlRunner.execute(LOAD_ALL_TASKS_SQL, null, loadAllTasksResultHandler, Task, databaseErrorHandler);
        }

        private function loadAllTasksResultHandler(result:SQLResult):void
        {
            for each(var task:Task in result.data)
            {
                var taskStatus:Status = statusListModel.getStatusFromId(task.statusId);
                statusListModel.addTaskToStatus(task, taskStatus);
                taskListModel.addTask(task);
            }
        }

        public function loadTaskById(id:int):void
        {
            sqlRunner.execute(LOAD_TASK_SQL, {taskId:id}, loadTaskResultHandler, Task);
        }

        private function loadTaskResultHandler(result:SQLResult):void
        {
            var task:Task = result.data[0] as Task;
            var taskStatus:Status = statusListModel.getStatusFromId(task.statusId);

            task = taskListModel.updateTask(task);

            statusListModel.addTaskToStatus(task, taskStatus);
        }

        public function save(task:Task):void
        {
            var params:Object = task.toParamObject();

            sqlRunner.executeModify(Vector.<QueuedStatement>(
                    [new QueuedStatement(SAVE_TASK_SQL, params)]), saveTaskResultHandler, databaseErrorHandler);
        }


        private function saveTaskResultHandler(results:Vector.<SQLResult>):void
        {
            var result:SQLResult = results[0];
            if (result.rowsAffected > 0)
            {
                var id:Number = result.lastInsertRowID;
                loadTaskById(id);
            }
        }

        public function deleteTask(task:Task):void
        {
            sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(DELETE_TASK_SQL, {taskId:task.taskId})]),
                    deleteTaskResult, databaseErrorHandler);
        }

        private function deleteTaskResult(results:Vector.<SQLResult>):void
        {
            //pass
        }

        private function databaseErrorHandler(error:SQLError):void
        {
            dispatch(new DatabaseErrorHandlerEvent(error.message));
        }

        [Embed(source="/assets/data/sql/tasks/SaveTask.sql", mimeType="application/octet-stream")]
        private static const SaveTaskStatementText:Class;
        public static const SAVE_TASK_SQL:String = new SaveTaskStatementText();

        [Embed(source="/assets/data/sql/tasks/DeleteTask.sql", mimeType="application/octet-stream")]
        private static const DeleteTaskStatementText:Class;
        public static const DELETE_TASK_SQL:String = new DeleteTaskStatementText();

        [Embed(source="/assets/data/sql/tasks/LoadTask.sql", mimeType="application/octet-stream")]
        private static const LoadTaskStatementText:Class;
        public static const LOAD_TASK_SQL:String = new LoadTaskStatementText();

        [Embed(source="/assets/data/sql/tasks/LoadAllTasks.sql", mimeType="application/octet-stream")]
        private static const LoadAllTasksStatementText:Class;
        public static const LOAD_ALL_TASKS_SQL:String = new LoadAllTasksStatementText();
    }
}