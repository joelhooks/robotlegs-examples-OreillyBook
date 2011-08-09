package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class DesignCreationEventTest extends TestCase
    {
        protected var instance:DesignCreationEvent;

        protected static const ROWS:uint = 3;
        protected static const COLUMNS:uint = 4;
        protected static const DESIGN_NAME:String = "Design name";
        protected static const EVENT_TYPE:String = "testEvent";


        public function DesignCreationEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignCreationEvent(EVENT_TYPE, ROWS, COLUMNS, DESIGN_NAME);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignCreationEvent", instance is DesignCreationEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:DesignCreationEvent = instance.clone() as DesignCreationEvent;
            assertTrue("DesignCreationEvent can be cloned to correct class", clone is DesignCreationEvent);
            assertEquals("DesignCreationEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("DesignCreationEvent.DESIGN_CREATED has correct string", DesignCreationEvent.DESIGN_CREATED, 'DesignCreationEvent.designCreated');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_rows():void
        {
            assertEquals("Get rows", ROWS, instance.rows);
        }

        public function test_get_columns():void
        {
            assertEquals("Get columns", COLUMNS, instance.columns);
        }

        public function test_get_designName():void
        {
            assertEquals("Get designName", DESIGN_NAME, instance.designName);
        }

    }
}