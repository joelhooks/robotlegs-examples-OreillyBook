package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class DesignSaveEventTest extends TestCase
    {
        protected var instance:DesignSaveEvent;
        protected static const DESIGN_NAME:String = "design name";
        protected static const EVENT_TYPE:String = "testEvent";

        public function DesignSaveEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignSaveEvent(EVENT_TYPE, DESIGN_NAME);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignSaveEvent", instance is DesignSaveEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:DesignSaveEvent = instance.clone() as DesignSaveEvent;
            assertTrue("DesignSaveEvent can be cloned to correct class", clone is DesignSaveEvent);
            assertEquals("DesignSaveEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("DesignSaveEvent.SAVE_REQUESTED has correct string", DesignSaveEvent.SAVE_REQUESTED, 'DesignSaveEvent.saveRequested');
            assertEquals("DesignSaveEvent.SAVE_AS_REQUESTED has correct string", DesignSaveEvent.SAVE_AS_REQUESTED, 'DesignSaveEvent.saveAsRequested');
            assertEquals("DesignSaveEvent.SAVE_COMPLETED has correct string", DesignSaveEvent.SAVE_COMPLETED, 'DesignSaveEvent.saveCompleted');
            assertEquals("DesignSaveEvent.SAVE_FAILED has correct string", DesignSaveEvent.SAVE_FAILED, 'DesignSaveEvent.saveFailed');
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