package robotlegs.examples.kanban.controller.events
{
    import flash.events.Event;

    public class ConfigureDatabaseEvent extends Event
    {
        public static const CONFIGURE:String = "ConfigureDatabaseEvent";

        public function ConfigureDatabaseEvent(bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(CONFIGURE, bubbles, cancelable);
        }

        override public function clone():Event
        {
            return new ConfigureDatabaseEvent(bubbles, cancelable)
        }
    }
}