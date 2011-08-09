package robotlegs.examples.kanban.service
{
    import flash.events.Event;

    import mockolate.*;

    import org.flexunit.async.Async;
    import org.hamcrest.assertThat;
    import org.hamcrest.collection.hasItem;
    import org.hamcrest.number.greaterThan;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.strictlyEqualTo;

    import robotlegs.examples.kanban.model.StatusListModel;
    import robotlegs.examples.kanban.model.TaskListModel;
    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.model.vo.Task;
    import robotlegs.examples.kanban.service.helpers.ISQLRunnerDelegate;
    import robotlegs.examples.kanban.service.mock.MockTaskSQLRunnerDelegate;

    public class SqlTaskServiceTest
    {
        private var taskService:SQLTaskService;

        [Before(async)]
        public function setup():void
        {
            taskService = new SQLTaskService();
            taskService.statusListModel = new StatusListModel();
            taskService.taskListModel = new TaskListModel();
            initializeModels();
            prepareMockolates();
        }

        public function prepareMockolates():void
        {
            Async.proceedOnEvent(this, prepare(ISQLRunnerDelegate), Event.COMPLETE);
        }

        [Test]
        public function loadAllTasks_executesSqlStatement_statementEqualsLoadAll():void
        {
            var runner:MockTaskSQLRunnerDelegate = new MockTaskSQLRunnerDelegate();
            taskService.sqlRunner = runner;

            taskService.loadAllTasks();

            assertThat(runner.lastStatementExecuted, equalTo(SQLTaskService.LOAD_ALL_TASKS_SQL));
        }

        [Test]
        public function loadAllTasks_clearsTasksFromStatusListModel_lengthIsEqualToZero():void
        {
            var status:Status = new Status();
            var task:Task = new Task();

            initializeModels(status, task);
            taskService.sqlRunner = nice(ISQLRunnerDelegate);

            taskService.loadAllTasks();

            assertThat(status.tasks.length, equalTo(0))
        }

        [Test]
        public function loadAllTasks_updatesTaskListModelWithLoadedTasks_collectionLengthIsOne():void
        {
            taskService.sqlRunner = new MockTaskSQLRunnerDelegate();

            taskService.loadAllTasks();

            assertThat(taskService.taskListModel.tasks.length, equalTo(1));
        }

        [Test]
        public function loadAllTasks_updatesStatusWithTask_statusHasTasks():void
        {
            var status:Status = new Status();
            initializeModels(status);
            taskService.sqlRunner = new MockTaskSQLRunnerDelegate();

            taskService.loadAllTasks();

            assertThat(status.tasks.length, greaterThan(0));
        }

        [Test]
        public function save_executesSqlStatement_statementEqualsSave():void
        {
            var task:Task = new Task();
            var runner:MockTaskSQLRunnerDelegate = new MockTaskSQLRunnerDelegate();
            taskService.sqlRunner = runner;
            task.statusId = 1;

            taskService.save(task);

            assertThat(runner.allStatementsExecuted, hasItem(SQLTaskService.SAVE_TASK_SQL));
        }

        [Test]
        public function save_taskIsLoadedAfterSave_statementEqualsLoad():void
        {
            var task:Task = new Task();
            var runner:MockTaskSQLRunnerDelegate = new MockTaskSQLRunnerDelegate();
            taskService.sqlRunner = runner;
            task.statusId = 1;

            taskService.save(task);

            assertThat(runner.allStatementsExecuted, hasItem(SQLTaskService.LOAD_TASK_SQL));
        }

        [Test]
        public function save_taskIsAddedToModelWhenNew_tasksLengthGreaterThanZero():void
        {
            var taskListModel:TaskListModel = taskService.taskListModel;
            var task:Task = new Task();

            taskListModel.reset();
            taskService.sqlRunner = new MockTaskSQLRunnerDelegate();
            task.statusId = 1;
            task.taskId = 1;

            taskService.save(task);

            assertThat(taskListModel.tasks.length, equalTo(1));
        }

        [Test]
        public function save_existingTaskInstanceIsUpdatedAfterSave_objectsAreStrictlyEqual():void
        {
            var taskListModel:TaskListModel = taskService.taskListModel;
            var task:Task = new Task();
            var updatedTask:Task;

            taskListModel.addTask(task);
            taskService.sqlRunner = new MockTaskSQLRunnerDelegate();
            task.statusId = 1;
            task.taskId = 1;

            taskService.save(task);
            updatedTask = taskListModel.getTaskById(task.taskId);

            assertThat(updatedTask, strictlyEqualTo(task));
        }

        [Test]
        public function loadTaskById_executesLoadStatement_statementEqualsLoad():void
        {
            var runner:MockTaskSQLRunnerDelegate = new MockTaskSQLRunnerDelegate();
            taskService.sqlRunner = runner;

            taskService.loadTaskById(1);

            assertThat(runner.allStatementsExecuted, hasItem(SQLTaskService.LOAD_TASK_SQL));
        }

        [Test]
        public function deleteTasks_executesDeleteStatement_statementEqualsDelete():void
        {
            var task:Task = new Task();
            var runner:MockTaskSQLRunnerDelegate = new MockTaskSQLRunnerDelegate();
            taskService.sqlRunner = runner;

            taskService.deleteTask(task);

            assertThat(runner.allStatementsExecuted, hasItem(SQLTaskService.DELETE_TASK_SQL));
        }

        private function initializeModels(status:Status = null, task:Task = null):void
        {
            var statusListModel:StatusListModel = taskService.statusListModel;
            statusListModel.reset();

            //if nothing was passed in we need to default to new objects
            status ||= new Status();
            task ||= new Task();

            status.statusId = 1;
            task.taskId = task.statusId = 1;

            statusListModel.statuses.addItem(status);
            statusListModel.addTaskToStatus(task, status);
        }
    }
}