package mosaic.controller.events
{
    import flash.events.Event;

    public class DesignLoadEvent extends NamedDesignEvent
    {
        public static const LOAD_REQUESTED:String = "DesignLoadEvent.saveRequested";
        public static const LOAD_COMPLETED:String = "DesignLoadEvent.saveCompleted";
        public static const LOAD_FAILED:String = "DesignLoadEvent.saveFailed";


        public function DesignLoadEvent(type:String, designName:String)
        {
            super(type, designName);
        }

        override public function clone():Event
        {
            return new DesignLoadEvent(type, _designName);
        }
    }
}