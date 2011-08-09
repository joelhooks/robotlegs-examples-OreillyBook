package mosaic.controller.events
{

    import flash.events.Event;

    import mosaic.model.TileSupplyVO;

    public class TileSupplyListEvent extends Event
    {

        public static const CHANGED:String = "TileSupplyListEvent.changed";

        protected var _supplyList:Vector.<TileSupplyVO>;

        public function TileSupplyListEvent(type:String, supplyList:Vector.<TileSupplyVO>)
        {
            _supplyList = supplyList;
            super(type);
        }

        public function get supplyList():Vector.<TileSupplyVO>
        {
            return _supplyList;
        }

        override public function clone():Event
        {
            return new TileSupplyListEvent(type, _supplyList);
        }

    }
}