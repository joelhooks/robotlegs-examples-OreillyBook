package mosaic.controller.events
{

    import flash.events.Event;

    public class TileSuppliesCombinedEvent extends Event
    {

        public static const SUPPLIES_COMBINED:String = "TileSuppliesCombinedEvent.suppliesCombined";

        /**
         *    @constructor
         */
        public function TileSuppliesCombinedEvent(type:String, deleteID:uint, combineWithID:uint)
        {
            _deleteID = deleteID;
            _combineWithID = combineWithID;
            super(type);
        }

        protected var _deleteID:uint;

        public function get deleteID():uint
        {
            return _deleteID;
        }

        protected var _combineWithID:uint;

        public function get combineWithID():uint
        {
            return _combineWithID;
        }

        override public function clone():Event
        {
            return new TileSuppliesCombinedEvent(type, _deleteID, _combineWithID);
        }

    }
}
