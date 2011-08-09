package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class ConfigChangedEventTest extends TestCase
    {
        protected var instance:ConfigChangedEvent;
        protected static const EVENT_TYPE:String = "someEvent";

        public function ConfigChangedEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new ConfigChangedEvent(EVENT_TYPE);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is ConfigChangedEvent", instance is ConfigChangedEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:ConfigChangedEvent = instance.clone() as ConfigChangedEvent;
            assertTrue("ConfigChangedEvent can be cloned to correct class", clone is ConfigChangedEvent);
            assertEquals("ConfigChangedEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventType():void
        {
            assertEquals("Event has set correct type for ConfigChangedEvent.CHANGED", ConfigChangedEvent.CHANGED, "ConfigChangedEvent.changed");
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}