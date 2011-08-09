package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class CreateMosaicEventTest extends TestCase
    {
        protected var instance:CreateMosaicEvent;

        protected static const EVENT_TYPE:String = "testEvent";

        public function CreateMosaicEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new CreateMosaicEvent(EVENT_TYPE);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is CreateMosaicEvent", instance is CreateMosaicEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:CreateMosaicEvent = instance.clone() as CreateMosaicEvent;
            assertTrue("CreateMosaicEvent can be cloned to correct class", clone is CreateMosaicEvent);
            assertEquals("CreateMosaicEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("CreateMosaicEvent.NEW_MOSAIC_REQUESTED has correct string", CreateMosaicEvent.NEW_MOSAIC_REQUESTED, 'CreateMosaicEvent.newMosaicRequested');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}