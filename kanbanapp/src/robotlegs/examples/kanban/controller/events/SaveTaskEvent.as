package robotlegs.examples.kanban.controller.events
{
    import flash.events.Event;

    import robotlegs.examples.kanban.model.vo.Task;

    public class SaveTaskEvent extends Event
    {
        public static const SAVE:String = "SaveTaskEvent";

        private var _task:Task;

        public function get task():Task
        {
            return _task;
        }

        public function SaveTaskEvent(task:Task)
        {
            super(SAVE);

            _task = task;
        }

        override public function clone():Event
        {
            return new SaveTaskEvent(task);
        }
    }
}