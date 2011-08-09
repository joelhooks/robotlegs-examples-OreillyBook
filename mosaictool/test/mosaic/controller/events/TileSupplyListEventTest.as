package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    import mosaic.model.TileSupplyVO;

    public class TileSupplyListEventTest extends TestCase
    {
        protected var instance:TileSupplyListEvent;
        protected static const EVENT_TYPE:String = "Event type";
        protected static const SUPPLY_LIST:Vector.<TileSupplyVO> = new Vector.<TileSupplyVO>();

        public function TileSupplyListEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileSupplyListEvent(EVENT_TYPE, SUPPLY_LIST);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSupplyListEvent", instance is TileSupplyListEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:TileSupplyListEvent = instance.clone() as TileSupplyListEvent;
            assertTrue("TileSupplyListEvent can be cloned to correct class", clone is TileSupplyListEvent);
            assertEquals("TileSupplyListEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertTrue("TileSupplyListEvent.CHANGED has correct string", TileSupplyListEvent.CHANGED == 'TileSupplyListEvent.changed');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_supplyList():void
        {
            assertEquals("Get supplyList", SUPPLY_LIST, instance.supplyList);
        }

    }
}