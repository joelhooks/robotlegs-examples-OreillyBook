package mosaic.model
{

    import flash.events.EventDispatcher;

    public class TileSuppliesModelSupport extends TileSuppliesModel
    {

        public function TileSuppliesModelSupport()
        {
            // pass constants to the super constructor for properties
            eventDispatcher = new EventDispatcher();
        }
    }
}