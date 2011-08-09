package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class GroutEventTest extends TestCase
    {
        protected var instance:GroutEvent;

        protected static const COLOR:uint = 0x55FF99;
        protected static const EVENT_TYPE:String = "testEvent";

        public function GroutEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new GroutEvent(EVENT_TYPE, COLOR);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is GroutEvent", instance is GroutEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:GroutEvent = instance.clone() as GroutEvent;
            assertTrue("GroutEvent can be cloned to correct class", clone is GroutEvent);
            assertEquals("GroutEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("GroutEvent.COLOR_CHANGED has correct string", GroutEvent.COLOR_CHANGED, 'GroutEvent.colorChanged');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_color():void
        {
            assertEquals("Get color", COLOR, instance.color);
        }

    }
}