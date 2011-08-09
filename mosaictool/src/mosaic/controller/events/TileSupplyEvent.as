package mosaic.controller.events
{
    import flash.events.Event;

    public class TileSupplyEvent extends Event
    {
        public static const SUPPLY_ADDED:String = "TileSupplyEvent.supplyAdded";
        public static const SUPPLY_SELECTED:String = "TileSupplyEvent.supplySelected";
        public static const SUPPLY_DELETED:String = "TileSupplyEvent.supplyDeleted";
        public static const COLOR_CHANGED:String = "TileSupplyEvent.colorChanged";
        public static const SUPPLY_DELETION_REQUESTED:String = "TileSupplyEvent.supplyDeletionRequested";
        public static const SUPPLY_ADDITION_REQUESTED:String = "TileSupplyEvent.supplyAdditionRequested";
        public static const QUANTITY_CHANGED:String = "TileSupplyEvent.quantityChanged";
        public static const SELECTED_SUPPLY_COLOR_CHANGED:String = "TileSupplyEvent.selectedSupplyColorChanged";

        protected var _id:uint;
        protected var _color:uint;
        protected var _count:Number;

        public function TileSupplyEvent(type:String, id:uint, color:uint, count:Number)
        {
            _id = id;
            _color = color;
            _count = count;
            super(type);
        }

        public function get id():uint
        {
            return _id;
        }

        public function get color():uint
        {
            return _color;
        }

        public function get count():Number
        {
            return _count;
        }

        override public function clone():Event
        {
            return new TileSupplyEvent(type, _id, _color, _count);
        }
    }
}