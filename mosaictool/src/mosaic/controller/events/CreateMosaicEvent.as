package mosaic.controller.events
{

    import flash.events.Event;

    public class CreateMosaicEvent extends Event
    {

        public static const NEW_MOSAIC_REQUESTED:String = "CreateMosaicEvent.newMosaicRequested"

        public function CreateMosaicEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new CreateMosaicEvent(type);
        }
    }
}
