package mosaic.controller.events
{
    import flash.events.Event;

    public class GridReadyEvent extends Event
    {

        public static const READY:String = "GridReadyEvent.ready";

        public function GridReadyEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new GridReadyEvent(type);
        }

    }
}