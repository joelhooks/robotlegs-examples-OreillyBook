package mosaic.view.tilesupply
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.controller.events.TileSupplyListEvent;
    import mosaic.model.TileSupplyVO;
    import mosaic.model.TileSupplyVOSupport;

    import org.robotlegs.mvcs.Mediator;

    public class TileSupplyMenuMediatorTest extends TestCase
    {
        protected var instance:TileSupplyMenuMediator;

        public function TileSupplyMenuMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileSupplyMenuMediator();
            instance.view = new TileSupplyMenu();
            instance.setViewComponent(instance.view);
            instance.eventDispatcher = new EventDispatcher();
            instance.onRegister();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is TileSupplyMenuMediator", instance is TileSupplyMenuMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_clickingAddButton_dispatches_SUPPLY_ADDITION_REQUESTED():void
        {
            var handler:Function = addAsync(check_clickingAddButton_dispatches_SUPPLY_ADDITION_REQUESTED, 50);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.SUPPLY_ADDITION_REQUESTED, handler);

            UnitHelpers.clickItem(instance.view.addButton);
        }

        protected function check_clickingAddButton_dispatches_SUPPLY_ADDITION_REQUESTED(e:TileSupplyEvent):void
        {
            assertEquals('event is correct type', TileSupplyEvent.SUPPLY_ADDITION_REQUESTED, e.type);
        }

        public function test_SUPPLY_ADDED_adds_supply_on_view():void
        {
            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_ADDED, 1, 0xFF3344, 0);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("SUPPLY ADDED adds supply on view", 1, UnitHelpers.countInstancesOf(instance.view, TileSupplyDetailView));
        }

        public function test_CHANGED_adds_all_supplies_to_view_clearing_first():void
        {
            var supplyList:Vector.<TileSupplyVO> = createTileSupplyList();

            instance.view.addSupply(1, 0x000000, 3);

            var evt:TileSupplyListEvent = new TileSupplyListEvent(TileSupplyListEvent.CHANGED, supplyList);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("SUPPLY ADDED clears view and adds supplies", supplyList.length, UnitHelpers.countInstancesOf(instance.view, TileSupplyDetailView));
        }

        protected function createTileSupplyList():Vector.<TileSupplyVO>
        {
            var supplyList:Vector.<TileSupplyVO> = new Vector.<TileSupplyVO>();

            var iLength:uint = 5;
            for (var i:int = 0; i < iLength; i++)
            {
                supplyList.push(new TileSupplyVOSupport(i + 1));
            }

            return supplyList;
        }

    }
}