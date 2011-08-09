package robotlegs.examples.kanban.service.events
{
    import flash.events.Event;

    public class DatabaseReadyEvent extends Event
    {
        public static const READY:String = "DatabaseReadyEvent";

        public function DatabaseReadyEvent(bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(READY, bubbles, cancelable);
        }

        override public function clone():Event
        {
            return new DatabaseReadyEvent(bubbles, cancelable)
        }
    }
}