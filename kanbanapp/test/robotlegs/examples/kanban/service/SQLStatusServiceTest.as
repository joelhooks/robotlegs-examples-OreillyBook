package robotlegs.examples.kanban.service
{
    import org.hamcrest.assertThat;
    import org.hamcrest.collection.hasItem;
    import org.hamcrest.number.greaterThan;

    import robotlegs.examples.kanban.controller.events.StatusesLoadedEvent;
    import robotlegs.examples.kanban.model.StatusListModel;
    import robotlegs.examples.kanban.service.mock.MockEventDispatcher;
    import robotlegs.examples.kanban.service.mock.MockStatusSQLRunnerDelegate;

    public class SQLStatusServiceTest
    {
        private var statusService:SQLStatusService;
        private var eventDispatcher:MockEventDispatcher;

        [Before]
        public function setup():void
        {
            eventDispatcher = new MockEventDispatcher();
            statusService = new SQLStatusService();
            statusService.statusListModel = new StatusListModel();
            statusService.eventDispatcher = eventDispatcher;
            statusService.statusListModel.eventDispatcher = eventDispatcher;
        }

        [Test]
        public function loadStatuses_executesLoadStatusesStatement_statmentEqualsLoadStatuses():void
        {
            var runner:MockStatusSQLRunnerDelegate = new MockStatusSQLRunnerDelegate();
            statusService.sqlRunner = runner;

            statusService.loadStatuses();

            assertThat(runner.allStatementsExecuted, hasItem(SQLStatusService.LOAD_ALL_STATUSES_SQL))
        }

        [Test]
        public function loadStatuses_loadingStatusesUpdatesStatusesModel_modelStatusesLengthGreaterThanZero():void
        {
            var statusListModel:StatusListModel = statusService.statusListModel;
            statusService.sqlRunner = new MockStatusSQLRunnerDelegate();

            statusService.loadStatuses();

            assertThat(statusListModel.statuses.length, greaterThan(0));
        }

        [Test]
        public function loadStatuses_triggersStatusesUpdatedEventDispatch_eventTypeWasDispatched():void
        {
            statusService.sqlRunner = new MockStatusSQLRunnerDelegate();

            statusService.loadStatuses();

            assertThat(eventDispatcher.dispatchedEventTypes, hasItem(StatusesLoadedEvent.LOADED));
        }

    }
}