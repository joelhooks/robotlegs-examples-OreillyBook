package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class TileColorChangeEventTest extends TestCase
    {
        protected var instance:TileColorChangeEvent;
        protected static const ROW:uint = 4;
        protected static const COLUMN:uint = 3;
        protected static const COLOR:uint = 0x330000;
        protected static const EVENT_TYPE:String = "testEvent";

        public function TileColorChangeEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileColorChangeEvent(EVENT_TYPE, ROW, COLUMN, COLOR);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileColorChangeEvent", instance is TileColorChangeEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:TileColorChangeEvent = instance.clone() as TileColorChangeEvent;
            assertTrue("TileColorChangeEvent can be cloned to correct class", clone is TileColorChangeEvent);
            assertEquals("TileColorChangeEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("TileColorChangeEvent.CHANGED has correct string", TileColorChangeEvent.CHANGED, 'TileColorChangeEvent.changed');
            assertEquals("TileColorChangeEvent.DEFAULT_CHANGED has correct string", TileColorChangeEvent.DEFAULT_CHANGED, 'TileColorChangeEvent.defaultChanged');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_row():void
        {
            assertEquals("Get row", ROW, instance.row);
        }

        public function test_get_column():void
        {
            assertEquals("Get column", COLUMN, instance.column);
        }

        public function test_get_color():void
        {
            assertEquals("Get color", COLOR, instance.color);
        }
    }
}