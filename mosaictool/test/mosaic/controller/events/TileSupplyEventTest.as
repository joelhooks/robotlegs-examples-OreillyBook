package mosaic.controller.events
{

    import asunit.framework.TestCase;

    import flash.events.Event;

    public class TileSupplyEventTest extends TestCase
    {
        protected var instance:TileSupplyEvent;
        protected static const ID:uint = 3;
        protected static const COLOR:uint = 0xFF00FF;
        protected static const COUNT:Number = 345.5;
        protected static const EVENT_TYPE:String = "testEvent";

        public function TileSupplyEventTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileSupplyEvent(EVENT_TYPE, ID, COLOR, COUNT);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSupplyEvent", instance is TileSupplyEvent);
        }

        public function testIsEvent():void
        {
            assertTrue("instance is Event", instance is Event);
        }

        public function testCloneReturnsSameEvent():void
        {
            var clone:TileSupplyEvent = instance.clone() as TileSupplyEvent;
            assertTrue("TileSupplyEvent can be cloned to correct class", clone is TileSupplyEvent);
            assertEquals("TileSupplyEvent clone retains event type", clone.type, EVENT_TYPE);
        }

        public function testEventStrings():void
        {
            assertEquals("TileSupplyEvent.SUPPLY_ADDED has correct string", TileSupplyEvent.SUPPLY_ADDED, 'TileSupplyEvent.supplyAdded');
            assertEquals("TileSupplyEvent.SUPPLY_SELECTED has correct string", TileSupplyEvent.SUPPLY_SELECTED, 'TileSupplyEvent.supplySelected');
            assertEquals("TileSupplyEvent.SUPPLY_DELETED has correct string", TileSupplyEvent.SUPPLY_DELETED, 'TileSupplyEvent.supplyDeleted');
            assertEquals("TileSupplyEvent.COLOR_CHANGED has correct string", TileSupplyEvent.COLOR_CHANGED, 'TileSupplyEvent.colorChanged');
            assertEquals("TileSupplyEvent.SUPPLY_DELETION_REQUESTED has correct string", TileSupplyEvent.SUPPLY_DELETION_REQUESTED, 'TileSupplyEvent.supplyDeletionRequested');
            assertEquals("TileSupplyEvent.SUPPLY_ADDITION_REQUESTED has correct string", TileSupplyEvent.SUPPLY_ADDITION_REQUESTED, 'TileSupplyEvent.supplyAdditionRequested');
            assertEquals("TileSupplyEvent.QUANTITY_CHANGED has correct string", TileSupplyEvent.QUANTITY_CHANGED, 'TileSupplyEvent.quantityChanged');
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_get_id():void
        {
            assertEquals("Get id", ID, instance.id);
        }

        public function test_get_color():void
        {
            assertEquals("Get color", COLOR, instance.color);
        }

        public function test_get_count():void
        {
            assertEquals("Get count", COUNT, instance.count);
        }
    }
}