package mosaic.controller.events
{
    import flash.events.Event;

    public class TileColorChangeEvent extends Event
    {
        public static const CHANGED:String = "TileColorChangeEvent.changed";
        public static const DEFAULT_CHANGED:String = "TileColorChangeEvent.defaultChanged";
        public static const DEFAULT_LOADED:String = "TileColorChangeEvent.defaultLoaded";

        protected var _row:uint;
        protected var _column:uint;
        protected var _color:uint;
        protected var _id:uint;

        public function TileColorChangeEvent(type:String, row:uint, column:uint, color:uint)
        {
            _row = row;
            _column = column;
            _color = color;
            super(type);
        }

        public function get row():uint
        {
            return _row;
        }

        public function get column():uint
        {
            return _column;
        }

        public function get color():uint
        {
            return _color;
        }

        override public function clone():Event
        {
            return new TileColorChangeEvent(type, _row, _column, _color);
        }
    }
}