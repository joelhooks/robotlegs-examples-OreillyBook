package robotlegs.examples.kanban.model
{
    import mx.collections.ArrayCollection;

    import org.hamcrest.assertThat;
    import org.hamcrest.collection.hasItem;
    import org.hamcrest.core.not;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.notNullValue;
    import org.hamcrest.object.strictlyEqualTo;

    import robotlegs.examples.kanban.model.events.StatusesUpdatedEvent;
    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.model.vo.Task;
    import robotlegs.examples.kanban.service.mock.MockEventDispatcher;

    public class StatusListModelTest
    {
        private var statusListModel:StatusListModel;
        private var eventDispatcher:MockEventDispatcher;

        [Before]
        public function setup():void
        {
            statusListModel = new StatusListModel();
            eventDispatcher = new MockEventDispatcher();

            statusListModel.eventDispatcher = eventDispatcher;
        }

        [Test]
        public function statuses_isAnArrayCollectionByDefault_notNull():void
        {
            assertThat(statusListModel.statuses, notNullValue());
        }

        [Test]
        public function statuses_updatingStatusesDispatchesEvent_eventWasDispatched():void
        {
            statusListModel.statuses = new ArrayCollection();

            assertThat(eventDispatcher.dispatchedEventTypes, hasItem(StatusesUpdatedEvent.UPDATED));
        }

        [Test]
        public function getStatusFromId_returnsAppropriateStatus_returnedObjectEqualToTestObject():void
        {
            var status:Status = new Status();
            var returnedStatus:Status;
            status.statusId = 1;
            statusListModel.statuses.addItem(status);

            returnedStatus = statusListModel.getStatusFromId(status.statusId);

            assertThat(returnedStatus, strictlyEqualTo(status));
        }

        [Test]
        public function addTaskToStatus_addsTaskToStatus_statusHasTask():void
        {
            var status:Status = new Status();
            var task:Task = new Task();

            statusListModel.addTaskToStatus(task, status);

            assertThat(status.tasks, hasItem(task));
        }

        [Test]
        public function addTaskToStatus_removesTaskFromPreviousStatus_statusDoesNotHaveTask():void
        {
            var oldStatus:Status = new Status();
            var newStatus:Status = new Status();
            var task:Task = new Task();

            statusListModel.addTaskToStatus(task, oldStatus);
            statusListModel.addTaskToStatus(task, newStatus);

            assertThat(oldStatus.tasks, not(hasItem(task)));
        }

        [Test]
        public function addTaskToStatus_addsStatusToTask_taskStatusPropertyEqualsStatus():void
        {
            var status:Status = new Status();
            var task:Task = new Task();

            statusListModel.addTaskToStatus(task, status);

            assertThat(task.status, strictlyEqualTo(status));
        }

        [Test]
        public function reset_removesAllStatuses_statusesCollectionLengthEqualsZero():void
        {
            var status:Status = new Status();
            statusListModel.statuses.addItem(status);

            statusListModel.reset();

            assertThat(statusListModel.statuses.length, equalTo(0));
        }

        [Test]
        public function reset_removesAllTasksFromStatusesInModel_statusTasksLengthEqualsZero():void
        {
            var status:Status = new Status();
            var task:Task = new Task();
            statusListModel.statuses.addItem(status);
            statusListModel.addTaskToStatus(task, status);

            statusListModel.reset();

            assertThat(status.tasks.length, equalTo(0));
        }

        [Test]
        public function removeAllTasks_removesAllTasksFromStatusesInModel_statusTaskLengthsEqualsZero():void
        {
            var status:Status = new Status();
            var task:Task = new Task();
            statusListModel.statuses.addItem(status);
            statusListModel.addTaskToStatus(task, status);

            statusListModel.removeAllTasks();

            assertThat(status.tasks.length, equalTo(0));
        }

        [Test]
        public function removeTaskFromAllStatuses_removesAllTasksFromStatusesInModel_statusTaskLengthsEqualsZero():void
        {
            var status:Status = new Status();
            var task:Task = new Task();
            statusListModel.statuses.addItem(status);
            statusListModel.addTaskToStatus(task, status);

            statusListModel.removeAllTasks();

            assertThat(status.tasks.length, equalTo(0));
        }
    }
}