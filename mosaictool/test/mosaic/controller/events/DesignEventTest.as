package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class DesignEventTest extends TestCase
    {
        protected var instance:DesignEvent;

        protected static const COLORS:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();
        protected static const EVENT_TYPE:String = "testEvent";

        public function DesignEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignEvent(EVENT_TYPE, COLORS);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignEvent", instance is DesignEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:DesignEvent = instance.clone() as DesignEvent;
            assertTrue("DesignEvent can be cloned to correct class", clone is DesignEvent);
            assertEquals("DesignEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("DesignEvent.DESIGN_COLORS_CHANGED has correct string", DesignEvent.DESIGN_COLORS_CHANGED, 'DesignEvent.designColorsChanged');
            assertEquals("DesignEvent.DESIGN_MODEL_CHANGED has correct string", DesignEvent.DESIGN_MODEL_CHANGED, 'DesignEvent.designModelChanged');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_colors():void
        {
            assertEquals("Get colors", COLORS, instance.colors);
        }

    }
}