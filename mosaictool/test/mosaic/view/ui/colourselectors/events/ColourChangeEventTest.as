package mosaic.view.ui.colorselectors.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class ColorChangeEventTest extends TestCase
    {
        protected var instance:ColorChangeEvent;
        protected static const COLOR:uint = 0x334455;
        protected static const EVENT_TYPE:String = "testEvent";

        public function ColorChangeEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new ColorChangeEvent(EVENT_TYPE, COLOR);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is ColorChangeEvent", instance is ColorChangeEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:ColorChangeEvent = instance.clone() as ColorChangeEvent;
            assertTrue("ColorChangeEvent can be cloned to correct class", clone is ColorChangeEvent);
            assertEquals("ColorChangeEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("ColorChangeEvent.CHANGED has correct string", ColorChangeEvent.CHANGED, 'ColorChangeEvent.changed');
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