package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class DesignLoadEventTest extends TestCase
    {
        protected var instance:DesignLoadEvent;
        protected static const DESIGN_NAME:String = "design name";
        protected static const EVENT_TYPE:String = "testEvent";

        public function DesignLoadEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignLoadEvent(EVENT_TYPE, DESIGN_NAME);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignLoadEvent", instance is DesignLoadEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:DesignLoadEvent = instance.clone() as DesignLoadEvent;
            assertTrue("DesignLoadEvent can be cloned to correct class", clone is DesignLoadEvent);
            assertEquals("DesignLoadEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("DesignLoadEvent.LOAD_REQUESTED has correct string", DesignLoadEvent.LOAD_REQUESTED, 'DesignLoadEvent.saveRequested');
            assertEquals("DesignLoadEvent.LOAD_COMPLETED has correct string", DesignLoadEvent.LOAD_COMPLETED, 'DesignLoadEvent.saveCompleted');
            assertEquals("DesignLoadEvent.LOAD_FAILED has correct string", DesignLoadEvent.LOAD_FAILED, 'DesignLoadEvent.saveFailed');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_designName():void
        {
            assertEquals("Get designName", DESIGN_NAME, instance.designName);
        }

    }
}