package robotlegs.examples.kanban.controller.events
{
    import flash.events.Event;

    import robotlegs.examples.kanban.model.vo.Status;
    import robotlegs.examples.kanban.model.vo.Task;

    public class UpdateTaskWithStatusEvent extends Event
    {
        public static const UPDATE:String = "UpdateTaskWithStatusEvent";

        private var _task:Task;

        public function get task():Task
        {
            return _task;
        }

        private var _status:Status;

        public function get status():Status
        {
            return _status;
        }

        public function UpdateTaskWithStatusEvent(task:Task, status:Status)
        {
            super(UPDATE);

            _task = task;
            _status = status;
        }

        override public function clone():Event
        {
            return new UpdateTaskWithStatusEvent(task, status);
        }
    }
}