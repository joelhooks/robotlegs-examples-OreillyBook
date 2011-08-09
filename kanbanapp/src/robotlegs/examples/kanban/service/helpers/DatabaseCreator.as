package robotlegs.examples.kanban.service.helpers
{
    import com.probertson.data.QueuedStatement;

    import flash.data.SQLResult;
    import flash.errors.SQLError;
    import flash.events.SQLErrorEvent;

    import org.robotlegs.mvcs.Actor;

    import robotlegs.examples.kanban.service.events.DatabaseReadyEvent;

    public class DatabaseCreator extends Actor
    {
        [Inject]
        public var sqlRunner:ISQLRunnerDelegate;

        public function createDatabaseStructure():void
        {
            var statements:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
            statements[statements.length] = new QueuedStatement(CREATE_STATUSES_SQL);
            statements[statements.length] = new QueuedStatement(CREATE_TASKS_SQL);
            statements[statements.length] = new QueuedStatement(CREATE_DEFAULT_STATUSES_SQL);

            sqlRunner.executeModify(statements, executeBatchCompleteHandler, executeBatchErrorHandler, null);
        }

        private function executeBatchCompleteHandler(results:Vector.<SQLResult>):void
        {
            dispatch(new DatabaseReadyEvent());
        }


        private function executeBatchErrorHandler(error:SQLError):void
        {
            dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
        }

        // ------- SQL statements -------

        [Embed(source="/assets/data/sql/create/CreateTableStatuses.sql", mimeType="application/octet-stream")]
        private static const CreateStatusesStatementText:Class;
        public static const CREATE_STATUSES_SQL:String = new CreateStatusesStatementText();

        [Embed(source="/assets/data/sql/create/CreateTableTasks.sql", mimeType="application/octet-stream")]
        private static const CreateTasksStatementText:Class;
        public static const CREATE_TASKS_SQL:String = new CreateTasksStatementText();

        [Embed(source="/assets/data/sql/create/CreateDefaultsStatuses.sql", mimeType="application/octet-stream")]
        private static const CreateDefaultStatusesStatementText:Class;
        public static const CREATE_DEFAULT_STATUSES_SQL:String = new CreateDefaultStatusesStatementText();

    }
}