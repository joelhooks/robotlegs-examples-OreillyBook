package mosaic.model
{

    import flash.events.EventDispatcher;

    public class MosaicDesignModelSupport extends MosaicDesignModel
    {

        public function MosaicDesignModelSupport()
        {

            eventDispatcher = new EventDispatcher();
        }

    }
}