package robotlegs.examples.kanban.service.mock
{
    import com.probertson.data.QueuedStatement;

    import flash.data.SQLResult;

    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.service.SQLStatusService;
    import robotlegs.examples.kanban.service.helpers.ISQLRunnerDelegate;

    public class MockStatusSQLRunnerDelegate extends MockSQLRunnerDelegateBase implements ISQLRunnerDelegate
    {
        public function execute(sql:String, parameters:Object, handler:Function, itemClass:Class = null, errorHandler:Function = null):void
        {
            lastStatementExecuted = sql;
            allStatementsExecuted.push(lastStatementExecuted);
            parametersSent = parameters;

            switch (sql)
            {
                case SQLStatusService.LOAD_ALL_STATUSES_SQL:
                    handler.call(null, loadAllStatuses());
                    break;
            }
        }

        private function loadAllStatuses():SQLResult
        {
            return new SQLResult([new Status()], 1, true, 1);
        }

        public function executeModify(statementBatch:Vector.<QueuedStatement>, resultHandler:Function, errorHandler:Function, progressHandler:Function = null):void
        {
            lastStatementExecuted = statementBatch[0].statementText;
            allStatementsExecuted.push(lastStatementExecuted);
            parametersSent = statementBatch[0].parameters;
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