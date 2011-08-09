package mosaic.view.ui.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class LoadSelectorEventTest extends TestCase
    {
        protected var instance:LoadSelectorEvent;
        protected static const EVENT_TYPE:String = "someEvent";

        protected static const DESIGN_NAME:String = "design name";

        public function LoadSelectorEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new LoadSelectorEvent(EVENT_TYPE, DESIGN_NAME);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is LoadSelectorEvent", instance is LoadSelectorEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:LoadSelectorEvent = instance.clone() as LoadSelectorEvent;
            assertTrue("LoadSelectorEvent can be cloned to correct class", clone is LoadSelectorEvent);
            assertEquals("LoadSelectorEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventType():void
        {
            assertEquals("Event has set correct type for LoadSelectorEvent.LOAD_CLICKED", LoadSelectorEvent.LOAD_CLICKED, "LoadSelectorEvent.loadClicked");
        }

        public function test_get_designName():void
        {
            assertEquals("Get designName", DESIGN_NAME, instance.designName);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}