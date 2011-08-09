package robotlegs.examples.kanban.model
{
    import mx.collections.ArrayCollection;

    import org.robotlegs.mvcs.Actor;

    import robotlegs.examples.kanban.model.vo.Task;

    public class TaskListModel extends Actor
    {
        private var _tasks:ArrayCollection;

        public function get tasks():ArrayCollection
        {
            return _tasks ||= new ArrayCollection();
        }

        public function updateTask(withTask:Task):Task
        {
            for each(var task:Task in tasks)
            {
                if (task.taskId == withTask.taskId)
                    return task.update(withTask);
            }

            addTask(withTask);

            return withTask;
        }

        public function getTaskById(id:int):Task
        {
            for each(var task:Task in tasks)
            {
                if (task.taskId == id)
                    return task;
            }

            return null;
        }

        public function addTask(task:Task):void
        {
            if (!tasks.contains(task))
                tasks.addItem(task);
        }

        public function reset():void
        {
            tasks.removeAll();
        }
    }
}