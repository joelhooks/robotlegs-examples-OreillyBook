package robotlegs.examples.kanban.service.mock
{
    import com.probertson.data.QueuedStatement;

    import flash.data.SQLResult;

    import robotlegs.examples.kanban.model.vo.Task;
    import robotlegs.examples.kanban.service.SQLTaskService;
    import robotlegs.examples.kanban.service.helpers.ISQLRunnerDelegate;

    /**
     * This is a more robust mock for the SQLRunnerDelegate to test for
     * side effects that occur when methods are called on SQLTaskService
     */
    public class MockTaskSQLRunnerDelegate extends MockSQLRunnerDelegateBase implements ISQLRunnerDelegate
    {
        public function execute(sql:String, parameters:Object, handler:Function, itemClass:Class = null, errorHandler:Function = null):void
        {
            lastStatementExecuted = sql;
            allStatementsExecuted.push(lastStatementExecuted);
            parametersSent = parameters;

            switch (sql)
            {
                case SQLTaskService.LOAD_ALL_TASKS_SQL:
                    handler.call(null, loadTask());

                    break;

                case SQLTaskService.LOAD_TASK_SQL:
                    handler.call(null, loadTask());
                    break;
                default:
                    break;
            }
        }

        private function loadTask():SQLResult
        {
            var task:Task = new Task();
            var data:Array = [task];
            var result:SQLResult = new SQLResult(data);

            task.taskId = 1;
            task.statusId = 1;

            return result;
        }

        public function executeModify(statementBatch:Vector.<QueuedStatement>, resultHandler:Function, errorHandler:Function, progressHandler:Function = null):void
        {
            lastStatementExecuted = statementBatch[0].statementText;
            allStatementsExecuted.push(lastStatementExecuted);
            parametersSent = statementBatch[0].parameters;

            switch (lastStatementExecuted)
            {
                case SQLTaskService.SAVE_TASK_SQL:
                    resultHandler.call(null, saveTask());
                    break;
            }
        }

        private function saveTask():Vector.<SQLResult>
        {
            var task:Task = new Task();
            var result:SQLResult = new SQLResult([task], 1, true, 1);
            var results:Vector.<SQLResult> = new Vector.<SQLResult>();

            task.taskId = task.statusId = 1;
            results.push(result);

            return results;
        }

        public function get numConnections():int
        {
            return 0;
        }

        public function get connectionErrorHandler():Function
        {
            return null;
        }

        public function set connectionErrorHandler(value:Function):void
        {
        }

        public function close(resultHandler:Function, errorHandler:Function = null):void
        {
        }
    }
}