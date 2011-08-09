package robotlegs.examples.kanban.service
{
    import flash.data.SQLResult;
    import flash.errors.SQLError;

    import mx.collections.ArrayCollection;

    import org.robotlegs.mvcs.Actor;

    import robotlegs.examples.kanban.controller.events.DatabaseErrorHandlerEvent;
    import robotlegs.examples.kanban.controller.events.StatusesLoadedEvent;
    import robotlegs.examples.kanban.model.StatusListModel;
    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.service.helpers.ISQLRunnerDelegate;

    public class SQLStatusService extends Actor implements IStatusService
    {
        [Inject]
        public var sqlRunner:ISQLRunnerDelegate;

        [Inject]
        public var statusListModel:StatusListModel;

        public function loadStatuses():void
        {
            statusListModel.reset();
            sqlRunner.execute(LOAD_ALL_STATUSES_SQL, null, loadStatusesResultHandler, Status, databaseFaultHandler);
        }

        private function loadStatusesResultHandler(result:SQLResult):void
        {
            statusListModel.statuses = new ArrayCollection(result.data);
            dispatch(new StatusesLoadedEvent());
        }

        private function databaseFaultHandler(error:SQLError):void
        {
            dispatch(new DatabaseErrorHandlerEvent(error.message));
        }

        [Embed(source="/assets/data/sql/statuses/LoadAllStatuses.sql", mimeType="application/octet-stream")]
        private static const LoadAllStatusesStatementText:Class;
        public static const LOAD_ALL_STATUSES_SQL:String = new LoadAllStatusesStatementText();
    }
}