package mosaic.view.grid
{

    import asunit.framework.TestCase;

    public class TileFactoryTest extends TestCase
    {
        protected var instance:TileFactory;
        protected var DEFAULT_COLOR:uint = 0x00FF00;
        protected var CHANGED_COLOR:uint = 0xFF0000;
        protected var DEFAULT_TILE_SIZE:Number = 32;
        protected var CHANGED_TILE_SIZE:Number = 34;

        public function TileFactoryTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileFactory(DEFAULT_TILE_SIZE, DEFAULT_COLOR);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileFactory", instance is TileFactory);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_create_tile_returns_a_tile():void
        {
            var tileCreated:ITileView = instance.createTile();
            assertNotNull("Create tile returns a tile", tileCreated);
        }

        public function test_tile_has_default_color():void
        {
            var tileCreated:TileView = instance.createTile() as TileView;
            var tileSupport:TileViewSupport = new TileViewSupport(tileCreated);

            assertEquals("tile has correct default color", DEFAULT_COLOR, tileSupport.tileColor);
        }

        public function test_tile_dimensions_match_those_given():void
        {
            var tileCreated:ITileView = instance.createTile();
            var tileSupport:TileViewSupport = new TileViewSupport(tileCreated);

            assertEquals("tile has correct width", DEFAULT_TILE_SIZE, tileSupport.width);
            assertEquals("tile has correct height", DEFAULT_TILE_SIZE, tileSupport.height);
        }

        public function test_create_quarterTile_returns_a_quarterTile():void
        {
            var quarterTileCreated:QuarterTileView = instance.createQuarterTile() as QuarterTileView;
            assertNotNull("Create quarterTile returns a quarterTile", quarterTileCreated);
        }

        public function test_quarterTile_has_default_color():void
        {
            var quarterTileCreated:ITileView = instance.createQuarterTile();
            var quarterTileSupport:TileViewSupport = new TileViewSupport(quarterTileCreated);

            assertEquals("quarterTile has correct default color", DEFAULT_COLOR, quarterTileSupport.tileColor);
        }

        public function test_quarterTile_dimensions_match_those_given():void
        {
            var quarterTileCreated:ITileView = instance.createQuarterTile();
            var quarterTileSupport:TileViewSupport = new TileViewSupport(quarterTileCreated);

            assertEquals("quarterTile has correct width", DEFAULT_TILE_SIZE, quarterTileSupport.width);
            assertEquals("quarterTile has correct height", DEFAULT_TILE_SIZE / 2, quarterTileSupport.height);
        }

        public function test_setting_color_changes_color_of_tiles_produced():void
        {
            instance.defaultColor = CHANGED_COLOR;
            var tileCreated:ITileView = instance.createTile();
            var tileSupport:TileViewSupport = new TileViewSupport(tileCreated);

            assertEquals("Setting color changes color of tiles produced", CHANGED_COLOR, tileSupport.tileColor);
        }

        public function test_setting_color_changes_color_of_quarterTiles_produced():void
        {
            instance.defaultColor = CHANGED_COLOR;
            var quarterTileCreated:ITileView = instance.createQuarterTile();
            var quarterTileSupport:TileViewSupport = new TileViewSupport(quarterTileCreated);

            assertEquals("Setting color changes color of quarter tiles produced", CHANGED_COLOR, quarterTileSupport.tileColor);
        }

        public function test_setting_tileSize_changes_size_of_tiles_produced():void
        {
            instance.tileSize = CHANGED_TILE_SIZE;
            var tileCreated:ITileView = instance.createTile();
            var tileSupport:TileViewSupport = new TileViewSupport(tileCreated);

            assertEquals("tile has correct width", CHANGED_TILE_SIZE, tileSupport.width);
            assertEquals("tile has correct height", CHANGED_TILE_SIZE, tileSupport.height);
        }

        public function test_setting_tileSize_changes_size_of_quarterTiles_produced():void
        {
            instance.tileSize = CHANGED_TILE_SIZE;
            var quarterTileCreated:ITileView = instance.createQuarterTile();
            var quarterTileSupport:TileViewSupport = new TileViewSupport(quarterTileCreated);

            assertEquals("quarterTile has correct width", CHANGED_TILE_SIZE, quarterTileSupport.width);
            assertEquals("quarterTile has correct height", CHANGED_TILE_SIZE / 2, quarterTileSupport.height);
        }

        public function test_get_tileSize():void
        {
            assertEquals("Get tileSize", DEFAULT_TILE_SIZE, instance.tileSize);
        }

    }
}