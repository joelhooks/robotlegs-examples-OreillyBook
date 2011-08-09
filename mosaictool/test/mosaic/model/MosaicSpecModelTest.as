package mosaic.model
{

    import asunit.framework.TestCase;

    import org.robotlegs.mvcs.Actor;

    public class MosaicSpecModelTest extends TestCase
    {
        protected var instance:MosaicSpecModel;
        protected static const ROWS:uint = 12;
        protected static const COLUMNS:uint = 20;
        protected static const TILE_COLOR:uint = 0x330000;
        protected static const GROUT_COLOR:uint = 0x999999;

        public function MosaicSpecModelTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new MosaicSpecModel();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is MosaicSpecModel", instance is MosaicSpecModel);
        }

        public function testIsModel():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function test_implements_IMosaicSpecModel():void
        {
            assertTrue("Implements IMosaicSpecModel", instance is IMosaicSpecModel);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_set_rows():void
        {
            instance.rows = ROWS;
            assertEquals("Set rows", ROWS, instance.rows);
        }

        public function test_set_columns():void
        {
            instance.columns = COLUMNS;
            assertEquals("Set columns", COLUMNS, instance.columns);
        }

        public function test_set_defaultTileColor():void
        {
            instance.defaultTileColor = TILE_COLOR;
            assertEquals("Set defaultTileColor", TILE_COLOR, instance.defaultTileColor);
        }

        public function test_set_groutColor():void
        {
            instance.groutColor = GROUT_COLOR;
            assertEquals("Set groutColor", GROUT_COLOR, instance.groutColor);
        }
    }
}