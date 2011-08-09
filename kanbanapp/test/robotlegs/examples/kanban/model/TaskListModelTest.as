package robotlegs.examples.kanban.model
{
    import org.hamcrest.assertThat;
    import org.hamcrest.object.*;

    import robotlegs.examples.kanban.model.vo.Task;

    public class TaskListModelTest
    {
        private var taskListModel:TaskListModel;

        [Before]
        public function setup():void
        {
            taskListModel = new TaskListModel();
        }

        [Test]
        public function construct_modelHasTasksCollection_notNull():void
        {
            assertThat(taskListModel.tasks, notNullValue());
        }

        [Test]
        public function addTask_taskWasAddedToTasksCollection_isTrue():void
        {
            var task:Task = new Task();

            taskListModel.addTask(task);

            assertThat(taskListModel.tasks.contains(task), isTrue());
        }

        [Test]
        public function addTask_taskIsNotAddedIfAlreadyExists_collectionCountEqual():void
        {
            var task:Task = new Task();

            taskListModel.addTask(task);
            taskListModel.addTask(task);

            assertThat(taskListModel.tasks.length, equalTo(1));
        }

        [Test]
        public function updateTask_alsoAddsTaskNotInList_collectionCountEqual():void
        {
            var task:Task = new Task();

            taskListModel.updateTask(task);

            assertThat(taskListModel.tasks.length, equalTo(1));
        }

        [Test]
        public function updateTask_updatesTaskWithValues_taskNamesEqual():void
        {
            var task:Task = new Task("test");
            var updateTask:Task = new Task("update");

            taskListModel.addTask(task);
            taskListModel.updateTask(updateTask);

            assertThat(task.name, equalTo(updateTask.name));
        }

        [Test]
        public function updateTask_returnsTargetTaskIfNotInTasksCollection_isTrue():void
        {
            var task:Task = new Task();
            var updateTask:Task;

            updateTask = taskListModel.updateTask(task);

            assertThat(task, strictlyEqualTo(updateTask));
        }

        [Test]
        public function updateTask_returnsExistingTaskWhenIdIsEqual_isTrue():void
        {
            var task:Task = new Task("test");
            var updateTask:Task = new Task("update");

            taskListModel.addTask(task);
            taskListModel.updateTask(task);

            assertThat(task, strictlyEqualTo(task));
        }

        [Test]
        public function reset_clearsAllTasks_tasksLenghtEqualsZero():void
        {
            var task:Task = new Task("test");
            taskListModel.addTask(task);

            taskListModel.reset();

            assertThat(taskListModel.tasks.length, equalTo(0));
        }

        [Test]
        public function getTaskById_returnsAppropriateTask_returnedTaskEqualsGivenTask():void
        {
            var task:Task = new Task("test");
            var returnedTask:Task;
            task.taskId = 1;
            taskListModel.addTask(task);

            returnedTask = taskListModel.getTaskById(task.taskId);

            assertThat(returnedTask, strictlyEqualTo(task));
        }
    }
}