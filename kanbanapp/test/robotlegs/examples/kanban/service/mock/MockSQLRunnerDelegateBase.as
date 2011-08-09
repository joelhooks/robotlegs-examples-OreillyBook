package robotlegs.examples.kanban.service.mock
{
    public class MockSQLRunnerDelegateBase
    {
        public var lastStatementExecuted:String;
        public var allStatementsExecuted:Array = [];
        public var parametersSent:Object;

    }
}