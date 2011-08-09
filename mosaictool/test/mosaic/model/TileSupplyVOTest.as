package mosaic.model
{

    import asunit.framework.TestCase;

    public class TileSupplyVOTest extends TestCase
    {
        protected var instance:TileSupplyVO;

        protected static const ID:uint = 3;
        protected static const COLOR:uint = 0x336699;
        protected static const SAME_COLOR:uint = 0x336699;
        protected static const COUNT:Number = 345;
        protected static const NEW_ID:uint = 4;
        protected static const NEW_COLOR:uint = 0x330099;
        protected static const NEW_COUNT:uint = 567;

        public function TileSupplyVOTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileSupplyVO(ID, COLOR, COUNT);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSupplyVO", instance is TileSupplyVO);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_id():void
        {
            assertEquals("Get id", ID, instance.id);
        }

        public function test_get_color():void
        {
            assertEquals("Get color", COLOR, instance.color);
        }

        public function test_updateColor_changes_color():void
        {
            instance.updateColor(NEW_COLOR);
            assertEquals("Set color", NEW_COLOR, instance.color);
        }

        public function test_updateColor_returns_true_if_changed():void
        {
            assertTrue("UpdateColor returns true if changed", instance.updateColor(NEW_COLOR));
        }

        public function test_updateColor_returns_false_if_not_changed():void
        {
            assertFalse("UpdateColor returns false if not changed", instance.updateColor(COLOR));
        }

        public function test_get_count():void
        {
            assertEquals("Get count", COUNT, instance.count);
        }

        public function test_set_count():void
        {
            instance.count = NEW_COUNT;
            assertEquals("Set count", NEW_COUNT, instance.count);
        }

    }
}