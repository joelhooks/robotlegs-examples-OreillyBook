package mosaic.view.grid
{

    public class TileFactorySupport extends TileFactory
    {

        // Testable constants
        public static const TILE_SIZE:Number = 20;
        public static const TILE_COLOR:uint = 0x330000;

        //--------------------------------------------------------------------------
        //
        //  Initialization
        //
        //--------------------------------------------------------------------------

        public function TileFactorySupport()
        {
            // pass constants to the super constructor for properties
            super(TILE_SIZE, TILE_COLOR);
        }

        //--------------------------------------------------------------------------
        //
        //  Overridden API
        //
        //--------------------------------------------------------------------------


    }
}
