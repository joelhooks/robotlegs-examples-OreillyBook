package mosaic.controller.events
{

    import flash.events.Event;

    public class MosaicConfigServiceEvent extends Event
    {

        public static const LOAD_REQUESTED:String = "MosaicConfigServiceEvent.loadRequested";
        public static const LOAD_COMPLETED:String = "MosaicConfigServiceEvent.loadCompleted";
        public static const LOAD_FAILED:String = "MosaicConfigServiceEvent.loadFailed";
        public static const CONFIG_CREATED:String = "MosaicConfigServiceEvent.configCreated";
        public static const CONFIG_NOT_FOUND:String = "MosaicConfigServiceEvent.configNotFound";
        public static const SAVE_COMPLETED:String = "MosaicConfigServiceEvent.saveCompleted";

        /**
         *    @constructor
         */
        public function MosaicConfigServiceEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new MosaicConfigServiceEvent(type);
        }

    }
}
