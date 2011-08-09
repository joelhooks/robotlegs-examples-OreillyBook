package mosaic.controller.events
{

    import flash.events.Event;

    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;

    public class GroutEvent extends ColorChangeEvent
    {

        public static const COLOR_CHANGED:String = "GroutEvent.colorChanged";
        public static const COLOR_LOADED:String = "GroutEvent.colorLoaded";

        public function GroutEvent(type:String, color:uint)
        {
            super(type, color);
        }

        override public function clone():Event
        {
            return new GroutEvent(type, _color);
        }

    }
}