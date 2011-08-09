package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class MosaicConfigServiceEventTest extends TestCase
    {
        protected var instance:MosaicConfigServiceEvent;
        protected static const EVENT_TYPE:String = "testEvent";

        public function MosaicConfigServiceEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new MosaicConfigServiceEvent(EVENT_TYPE);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is MosaicConfigServiceEvent", instance is MosaicConfigServiceEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:MosaicConfigServiceEvent = instance.clone() as MosaicConfigServiceEvent;
            assertTrue("MosaicConfigServiceEvent can be cloned to correct class", clone is MosaicConfigServiceEvent);
            assertEquals("MosaicConfigServiceEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("MosaicConfigServiceEvent.LOAD_REQUESTED has correct string", MosaicConfigServiceEvent.LOAD_REQUESTED, 'MosaicConfigServiceEvent.loadRequested');
            assertEquals("MosaicConfigServiceEvent.LOAD_COMPLETED has correct string", MosaicConfigServiceEvent.LOAD_COMPLETED, 'MosaicConfigServiceEvent.loadCompleted');
            assertEquals("MosaicConfigServiceEvent.LOAD_FAILED has correct string", MosaicConfigServiceEvent.LOAD_FAILED, 'MosaicConfigServiceEvent.loadFailed');
            assertEquals("MosaicConfigServiceEvent.CONFIG_CREATED has correct string", MosaicConfigServiceEvent.CONFIG_CREATED, 'MosaicConfigServiceEvent.configCreated');
            assertEquals("MosaicConfigServiceEvent.CONFIG_NOT_FOUND has correct string", MosaicConfigServiceEvent.CONFIG_NOT_FOUND, 'MosaicConfigServiceEvent.configNotFound');
            assertEquals("MosaicConfigServiceEvent.SAVE_COMPLETED has correct string", MosaicConfigServiceEvent.SAVE_COMPLETED, 'MosaicConfigServiceEvent.saveCompleted');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}