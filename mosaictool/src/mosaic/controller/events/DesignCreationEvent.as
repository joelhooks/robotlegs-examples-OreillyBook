package mosaic.controller.events
{
    import flash.events.Event;

    public class DesignCreationEvent extends NamedDesignEvent
    {
        public static const DESIGN_CREATED:String = 'DesignCreationEvent.designCreated';

        protected var _rows:uint;
        protected var _columns:uint;

        public function DesignCreationEvent(type:String, rows:uint, columns:uint, designName:String)
        {
            _rows = rows;
            _columns = columns;
            super(type, designName);
        }

        public function get rows():uint
        {
            return _rows;
        }

        public function get columns():uint
        {
            return _columns;
        }

        override public function clone():Event
        {
            return new DesignCreationEvent(type, _rows, _columns, _designName);
        }

    }
}