package robotlegs.examples.kanban.controller.events
{
    import flash.events.Event;

    import robotlegs.examples.kanban.model.vo.Task;

    public class DeleteTaskEvent extends Event
    {
        public static const DELETE:String = "DeleteNewTaskEvent";

        private var _task:Task;

        public function get task():Task
        {
            return _task;
        }

        public function DeleteTaskEvent(task:Task)
        {
            super(DELETE);

            _task = task;
        }

        override public function clone():Event
        {
            return new DeleteTaskEvent(task);
        }
    }
}