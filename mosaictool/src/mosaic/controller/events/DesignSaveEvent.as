package mosaic.controller.events
{
    import flash.events.Event;

    public class DesignSaveEvent extends NamedDesignEvent
    {
        public static const SAVE_REQUESTED:String = "DesignSaveEvent.saveRequested";
        public static const SAVE_AS_REQUESTED:String = "DesignSaveEvent.saveAsRequested";
        public static const SAVE_COMPLETED:String = "DesignSaveEvent.saveCompleted";
        public static const SAVE_FAILED:String = "DesignSaveEvent.saveFailed";


        public function DesignSaveEvent(type:String, designName:String)
        {
            super(type, designName);
        }

        override public function clone():Event
        {
            return new DesignSaveEvent(type, _designName);
        }
    }
}