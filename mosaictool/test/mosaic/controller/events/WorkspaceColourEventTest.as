package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class WorkspaceColorEventTest extends TestCase
    {
        protected var instance:WorkspaceColorEvent;
        protected static const COLOR:uint = 0x336699;
        protected static const EVENT_TYPE:String = "testEvent";

        public function WorkspaceColorEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new WorkspaceColorEvent(EVENT_TYPE, COLOR);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is WorkspaceColorEvent", instance is WorkspaceColorEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:WorkspaceColorEvent = instance.clone() as WorkspaceColorEvent;
            assertTrue("WorkspaceColorEvent can be cloned to correct class", clone is WorkspaceColorEvent);
            assertEquals("WorkspaceColorEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("WorkspaceColorEvent.COLOR_CHANGED has correct string", WorkspaceColorEvent.COLOR_CHANGED, 'WorkspaceColorEvent.colorChanged');
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