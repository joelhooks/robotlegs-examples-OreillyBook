package mosaic.view.ui.colorselectors.events
{

    import flash.events.Event;

    public class ColorChangeEvent extends Event
    {

        public static const CHANGED:String = "ColorChangeEvent.changed";

        /**
         *    @constructor
         */
        public function ColorChangeEvent(type:String, color:uint)
        {
            _color = color;
            super(type);
        }

        protected var _color:uint;

        public function get color():uint
        {
            return _color;
        }


        override public function clone():Event
        {
            return new ColorChangeEvent(type, _color);
        }

    }
}
