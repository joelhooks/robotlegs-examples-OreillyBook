package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class GridReadyEventTest extends TestCase
    {
        protected var instance:GridReadyEvent;
        protected static const EVENT_TYPE:String = "someEvent";

        public function GridReadyEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new GridReadyEvent(EVENT_TYPE);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is GridReadyEvent", instance is GridReadyEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:GridReadyEvent = instance.clone() as GridReadyEvent;
            assertTrue("GridReadyEvent can be cloned to correct class", clone is GridReadyEvent);
            assertEquals("GridReadyEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventType():void
        {
            assertEquals("Event has set correct type for GridReadyEvent.READY", GridReadyEvent.READY, "GridReadyEvent.ready");
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}