package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class DesignListEventTest extends TestCase
    {
        protected var instance:DesignListEvent;
        protected static const EVENT_TYPE:String = "someEvent";
        protected static const DESIGN_LIST:Vector.<String> = new Vector.<String>();

        public function DesignListEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignListEvent(EVENT_TYPE, DESIGN_LIST);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignListEvent", instance is DesignListEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:DesignListEvent = instance.clone() as DesignListEvent;
            assertTrue("DesignListEvent can be cloned to correct class", clone is DesignListEvent);
            assertEquals("DesignListEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventType():void
        {
            assertEquals("Event has set correct type for DesignListEvent.CHANGED", DesignListEvent.CHANGED, "DesignListEvent.changed");
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_designList():void
        {
            assertEquals("Get designList", DESIGN_LIST, instance.designList);
        }

    }
}