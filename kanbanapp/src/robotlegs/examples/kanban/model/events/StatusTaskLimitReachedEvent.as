package robotlegs.examples.kanban.model.events
{
    import flash.events.Event;

    public class StatusTaskLimitReachedEvent extends Event
    {
        public static const LIMIT_REACHED:String = "StatusTaskLimitReachedEvent";

        public function StatusTaskLimitReachedEvent()
        {
            super(LIMIT_REACHED);
        }

        override public function clone():Event
        {
            return new StatusTaskLimitReachedEvent()
        }
    }
}