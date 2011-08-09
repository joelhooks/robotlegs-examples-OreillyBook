package mosaic.controller.events
{
    import flash.events.Event;

    public class ConfigChangedEvent extends Event
    {

        public static const CHANGED:String = "ConfigChangedEvent.changed";

        public function ConfigChangedEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new ConfigChangedEvent(type);
        }

    }
}