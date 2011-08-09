package robotlegs.examples.kanban.controller.events
{
    import flash.events.Event;

    public class StatusesLoadedEvent extends Event
    {
        public static const LOADED:String = "StatusesLoadedEvent";

        public function StatusesLoadedEvent(bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(LOADED, bubbles, cancelable);
        }

        override public function clone():Event
        {
            return new StatusesLoadedEvent(bubbles, cancelable)
        }
    }
}