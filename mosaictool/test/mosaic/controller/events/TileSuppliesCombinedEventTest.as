package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class TileSuppliesCombinedEventTest extends TestCase
    {
        protected var instance:TileSuppliesCombinedEvent;
        protected static const DELETE_ID:uint = 3;
        protected static const COMBINE_WITH_ID:uint = 4;
        protected static const EVENT_TYPE:String = "testEvent";

        public function TileSuppliesCombinedEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileSuppliesCombinedEvent(EVENT_TYPE, DELETE_ID, COMBINE_WITH_ID);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSuppliesCombinedEvent", instance is TileSuppliesCombinedEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:TileSuppliesCombinedEvent = instance.clone() as TileSuppliesCombinedEvent;
            assertTrue("TileSuppliesCombinedEvent can be cloned to correct class", clone is TileSuppliesCombinedEvent);
            assertEquals("TileSuppliesCombinedEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("TileSuppliesCombinedEvent.SUPPLIES_COMBINED has correct string", TileSuppliesCombinedEvent.SUPPLIES_COMBINED, 'TileSuppliesCombinedEvent.suppliesCombined');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_deleteID():void
        {
            assertEquals("Get deleteID", DELETE_ID, instance.deleteID);
        }

        public function test_get_combineWithID():void
        {
            assertEquals("Get combineWithID", COMBINE_WITH_ID, instance.combineWithID);
        }

    }
}