package mosaic.controller.events
{

    import flash.events.Event;

    public class DesignEvent extends Event
    {

        public static const DESIGN_COLORS_CHANGED:String = "DesignEvent.designColorsChanged";
        public static const DESIGN_MODEL_CHANGED:String = "DesignEvent.designModelChanged";
        public static const DESIGN_COLORS_LOADED:String = "DesignEvent.designColorsLoaded";

        /**
         *    @constructor
         */
        public function DesignEvent(type:String, colors:Vector.<Vector.<uint>>)
        {
            _colors = colors;
            super(type);
        }

        protected var _colors:Vector.<Vector.<uint>>;

        public function get colors():Vector.<Vector.<uint>>
        {
            return _colors;
        }

        override public function clone():Event
        {
            return new DesignEvent(type, _colors);
        }

    }
}
