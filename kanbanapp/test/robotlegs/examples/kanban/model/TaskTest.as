package robotlegs.examples.kanban.model
{
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.hasProperties;
    import org.hamcrest.object.nullValue;

    import robotlegs.examples.kanban.model.vo.Task;

    public class TaskTest
    {

        [Test]
        public function toParamObject_returnsGenericObjectWithCorrectPropertyValues_objectIsEqual():void
        {
            var paramObject:Object;
            var task:Task = new Task("testTask");
            task.description = "task description";
            task.statusId = 1;
            task.taskId = 1;

            paramObject = task.toParamObject();

            assertThat(task, hasProperties(paramObject));
        }

        [Test]
        public function toParamObject_zeroAsTaskIdResultsInNullTaskIdForParam_taskIdIsNull():void
        {
            var paramObject:Object;
            var task:Task = new Task("testTask");

            paramObject = task.toParamObject();

            assertThat(paramObject.taskId, nullValue());
        }

        [Test]
        public function toParamObject_zeroAsStatusIdResultsStatusOfOne_statusIdIsEqualToOne():void
        {
            var paramObject:Object;
            var task:Task = new Task("testTask");

            paramObject = task.toParamObject();

            assertThat(paramObject.statusId, equalTo(1));
        }
    }
}
