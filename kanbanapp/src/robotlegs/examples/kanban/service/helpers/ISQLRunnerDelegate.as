package robotlegs.examples.kanban.service.helpers
{
    import com.probertson.data.QueuedStatement;

    public interface ISQLRunnerDelegate
    {
        function get numConnections():int;

        function get connectionErrorHandler():Function;

        function set connectionErrorHandler(value:Function):void;

        function execute(sql:String, parameters:Object, handler:Function, itemClass:Class = null, errorHandler:Function = null):void;

        function executeModify(statementBatch:Vector.<QueuedStatement>, resultHandler:Function, errorHandler:Function, progressHandler:Function = null):void;

        function close(resultHandler:Function, errorHandler:Function = null):void;
    }
}