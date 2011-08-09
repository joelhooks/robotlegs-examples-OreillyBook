package mosaic.model
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;

    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.controller.events.TileSupplyListEvent;

    import org.robotlegs.mvcs.Actor;

    public class TileSuppliesModelTest extends TestCase
    {
        protected var instance:TileSuppliesModel;
        protected var _supplyList:Vector.<TileSupplyVO>;
        protected var _receivedEventsByID:Dictionary;

        protected static const ADDED_ID:uint = 99;
        protected static const ADDED_COLOR:uint = 0x336699;
        protected static const INCOMING_INDEX:uint = 2;
        protected static const OUTGOING_INDEX:uint = 3;
        protected static const CHANGED_ID:uint = 2;
        protected static const CHANGED_COLOR:uint = 0x345678;
        protected static const REMOVED_ID:uint = 2;
        protected static const TILES_PER_INDEX:Number = 10;
        protected static const SELECTED_SUPPLY_ID:uint = 4;

        public function TileSuppliesModelTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileSuppliesModel();
            instance.eventDispatcher = new EventDispatcher();
            _supplyList = createSupplyList(5);
            _receivedEventsByID = new Dictionary();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSuppliesModel", instance is TileSuppliesModel);
        }

        public function testIsModel():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_set_supplyList():void
        {
            var supplyList:Vector.<TileSupplyVO> = createSupplyList(5);

            instance.supplyList = supplyList;
            assertEqualsVectors("Set supplyList", supplyList, instance.supplyList);
        }

        public function test_addSupply_adds_a_supply_to_list():void
        {
            var noOfItems:uint = 6;
            instance.supplyList = createSupplyList(noOfItems);
            instance.addSupply(ADDED_ID, ADDED_COLOR);
            var lastVO:TileSupplyVO = instance.supplyList[noOfItems];
            assertTrue("AddSupply adds appropriate supply to list", voHasProperties(lastVO, ADDED_ID, ADDED_COLOR, 0));
        }

        public function test_switchTiles_increases_incoming_tile_supply_count():void
        {
            instance.supplyList = createSupplyList(5);

            var expectedCount:Number = createSupplyList(5)[INCOMING_INDEX - 1].count + 1;

            instance.switchTiles(OUTGOING_INDEX, INCOMING_INDEX);

            var actualCount:Number = instance.supplyList[INCOMING_INDEX - 1].count;

            assertEquals("SwitchTiles increases incoming tile supply count", expectedCount, actualCount);
        }

        public function test_switchTiles_decreases_outgoing_tile_supply_count():void
        {
            instance.supplyList = createSupplyList(5);

            var expectedCount:Number = createSupplyList(5)[OUTGOING_INDEX - 1].count - 1;

            instance.switchTiles(OUTGOING_INDEX, INCOMING_INDEX);

            var actualCount:Number = instance.supplyList[OUTGOING_INDEX - 1].count;

            assertEquals("SwitchTiles decreases outgoing tile supply count", expectedCount, actualCount);
        }

        public function test_switchTiles_increases_incoming_tile_supply_without_error_if_outgoing_is_zero():void
        {
            instance.supplyList = createSupplyList(5);

            var expectedCount:Number = createSupplyList(5)[INCOMING_INDEX - 1].count + 1;

            instance.switchTiles(0, INCOMING_INDEX);

            var actualCount:Number = instance.supplyList[INCOMING_INDEX - 1].count;

            assertEquals("SwitchTiles increases incoming tile supply without error if outgoing is zero", expectedCount, actualCount);
        }

        public function test_combineSupplies_removes_a_supply_from_the_list():void
        {
            var noOfItems:uint = 6;

            instance.supplyList = createSupplyList(noOfItems);
            instance.combineSupplies(OUTGOING_INDEX, INCOMING_INDEX);

            assertEquals("CombineSupplies removes a supply from the list", noOfItems - 1, instance.supplyList.length);
        }

        public function test_combineSupplies_removes_correct_supply():void
        {
            var noOfItems:uint = 6;

            var supplyList:Vector.<TileSupplyVO> = createSupplyList(noOfItems);

            instance.supplyList = supplyList.slice();
            instance.combineSupplies(OUTGOING_INDEX, INCOMING_INDEX);

            var expectedSupplyList:Vector.<TileSupplyVO> = supplyList.slice()
            expectedSupplyList.splice(OUTGOING_INDEX - 1, 1);

            assertEqualsVectors("CombineSupplies removes a supply from the list", expectedSupplyList, instance.supplyList);
        }

        public function test_combineSupplies_puts_the_outgoing_tiles_into_incoming_pot():void
        {
            var noOfItems:uint = 6;

            var supplyList:Vector.<TileSupplyVO> = createSupplyList(noOfItems);

            instance.supplyList = supplyList.slice();
            instance.combineSupplies(OUTGOING_INDEX, INCOMING_INDEX);

            var expectedCount:Number = (OUTGOING_INDEX + INCOMING_INDEX) * TILES_PER_INDEX;

            var incomingItem:TileSupplyVO = instance.supplyList[INCOMING_INDEX - 1];

            assertEquals("CombineSupplies puts the outgoing tiles into incoming pot", expectedCount, incomingItem.count);
        }

        public function test_removeSupply_removes_the_correct_supply():void
        {
            var noOfItems:uint = 6;

            var supplyList:Vector.<TileSupplyVO> = createSupplyList(noOfItems);

            instance.supplyList = supplyList.slice();
            instance.removeSupply(REMOVED_ID);

            var expectedSupplyList:Vector.<TileSupplyVO> = supplyList.slice()
            expectedSupplyList.splice(REMOVED_ID - 1, 1);

            assertEqualsVectors("RemoveSupply removes the correct supply", expectedSupplyList, instance.supplyList);
        }

        public function test_changeSupplyColors_updates_color_correctly():void
        {
            instance.supplyList = createSupplyList(5);
            instance.changeSupplyColor(2, CHANGED_COLOR);
            var changedSupply:TileSupplyVO = instance.supplyList[CHANGED_ID - 1];
            assertEquals("ChangeSupplyColors updates color correctly", CHANGED_COLOR, changedSupply.color);
        }

        public function test_set_selectedSupplyID():void
        {
            instance.supplyList = createSupplyList(4);
            instance.selectedSupplyID = SELECTED_SUPPLY_ID;
            assertEquals("Set selectedSupplyID", SELECTED_SUPPLY_ID, instance.selectedSupplyID);
        }

        public function test_setting_supplyList_makes_selected_ID_first_item():void
        {
            instance.supplyList = createSupplyList(5);
            instance.selectedSupplyID = 15;
            instance.supplyList = createSupplyList(5);
            assertEquals("Set supply id back to the first item in the supply list", 1, instance.selectedSupplyID);
        }

        public function test_adding_a_supply_dispatches_SUPPLY_ADDED():void
        {
            var noOfItems:uint = 6;

            instance.supplyList = createSupplyList(noOfItems);

            var handler:Function = addAsync(check_adding_a_supply_dispatches_SUPPLY_ADDED, 50);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.SUPPLY_ADDED, handler);

            instance.addSupply(ADDED_ID, ADDED_COLOR);
        }

        private function check_adding_a_supply_dispatches_SUPPLY_ADDED(e:TileSupplyEvent):void
        {
            assertEquals('event is correct type', TileSupplyEvent.SUPPLY_ADDED, e.type);
        }

        public function test_setting_supplyList_dispatches_TileSupplyListEvent_CHANGED():void
        {
            var handler:Function = addAsync(check_setting_supplyList_dispatches_TileSupplyListEvent_CHANGED, 50);
            instance.eventDispatcher.addEventListener(TileSupplyListEvent.CHANGED, handler);

            instance.supplyList = _supplyList;
        }

        private function check_setting_supplyList_dispatches_TileSupplyListEvent_CHANGED(e:TileSupplyListEvent):void
        {
            assertEqualsVectors("passes supply list correctly", _supplyList, e.supplyList);
        }

        public function test_color_change_id_is_selectedSupply_dispatches_SELECTED_SUPPLY_COLOR_CHANGED():void
        {
            instance.supplyList = createSupplyList(5);
            instance.selectedSupplyID = CHANGED_ID;

            var handler:Function = addAsync(check_color_change_id_is_selectedSupply_dispatches_SELECTED_SUPPLY_COLOR_CHANGED, 50);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.SELECTED_SUPPLY_COLOR_CHANGED, handler);

            instance.changeSupplyColor(CHANGED_ID, CHANGED_COLOR);
        }

        private function check_color_change_id_is_selectedSupply_dispatches_SELECTED_SUPPLY_COLOR_CHANGED(e:TileSupplyEvent):void
        {
            assertEquals('event has correct color', CHANGED_COLOR, e.color);
        }

        public function test_color_change_id_is_not_selectedSupply_does_not_dispatch_SELECTED_SUPPLY_COLOR_CHANGED():void
        {
            instance.supplyList = createSupplyList(5);
            instance.selectedSupplyID = CHANGED_ID + 1;

            var handler:Function = addAsync(failIfCalled, 50, handleNonFiring);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.SELECTED_SUPPLY_COLOR_CHANGED, handler);

            instance.changeSupplyColor(CHANGED_ID, CHANGED_COLOR);
        }

        private function failIfCalled(e:TileSupplyEvent):void
        {
            assertTrue("should not have fired", false);
        }

        protected function handleNonFiring(e:Event):void
        {
            assertTrue("should have fired", true);
        }

        public function test_switchTiles_dispatches_QUANTITY_CHANGED_for_switched_tiles():void
        {
            instance.supplyList = _supplyList;
            var expectedOutgoingCount:Number = _supplyList[OUTGOING_INDEX - 1].count - 1;
            var expectedIncomingCount:Number = _supplyList[INCOMING_INDEX - 1].count + 1;

            instance.eventDispatcher.addEventListener(TileSupplyEvent.QUANTITY_CHANGED, captureTileCountUpdates);

            instance.switchTiles(OUTGOING_INDEX, INCOMING_INDEX);

            assertEquals("SwitchTiles decreases outgoing tile supply count", expectedOutgoingCount, _receivedEventsByID[OUTGOING_INDEX].count);
            assertEquals("SwitchTiles decreases incoming tile supply count", expectedIncomingCount, _receivedEventsByID[INCOMING_INDEX].count);
        }

        protected function captureTileCountUpdates(e:TileSupplyEvent):void
        {
            _receivedEventsByID[e.id] = e;
        }

        protected function createSupplyList(length:uint):Vector.<TileSupplyVO>
        {
            var supplyList:Vector.<TileSupplyVO> = new Vector.<TileSupplyVO>();

            var iLength:uint = length;
            for (var i:int = 0; i < iLength; i++)
            {
                var color:uint = 0x111111 * i;
                var count:Number = i * TILES_PER_INDEX;
                supplyList[i] = new TileSupplyVOSupport(i + 1);
            }
            return supplyList;
        }

        protected function voHasProperties(vo1:TileSupplyVO, id:uint, color:uint, count:Number):Boolean
        {
            if (vo1.id != id) return false;
            if (vo1.color != color) return false;
            if (vo1.count != count) return false;

            return true;
        }


    }
}