package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.stub;

    import mosaic.controller.events.DesignEvent;
    import mosaic.controller.events.GroutEvent;
    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.model.DesignToColorsTranslator;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.MosaicDesignModelSupport;
    import mosaic.model.TileSuppliesModelSupport;
    import mosaic.model.TileSupplyVO;

    import org.robotlegs.mvcs.Command;

    public class RestoreGridStatusCommandTest extends TestCase
    {
        protected var instance:RestoreGridStatusCommand;

        protected static const DESIGN:Vector.<Vector.<uint>> = Vector.<Vector.<uint>>([Vector.<uint>([3,0,3])]);
        protected static const TILE_COLOR:uint = 0x334455;
        protected static const TILE_SUPPLIES:Vector.<TileSupplyVO> = Vector.<TileSupplyVO>([new TileSupplyVO(3, TILE_COLOR, 5), new TileSupplyVO(4, TILE_COLOR + 10, 5)]);
        protected static const DEFAULT_COLOR:uint = 0x333333;
        protected static const PROCESSED_DESIGN:Vector.<Vector.<uint>> = Vector.<Vector.<uint>>([Vector.<uint>([TILE_COLOR,DEFAULT_COLOR,TILE_COLOR])]);
        protected static const GROUT_COLOR:uint = 0x444444;

        public function RestoreGridStatusCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IMosaicSpecModel);
            mockolateMaker.addEventListener(Event.COMPLETE, prepareCompleteHandler);
        }

        private function prepareCompleteHandler(e:Event):void
        {
            IEventDispatcher(e.target).removeEventListener(Event.COMPLETE, prepareCompleteHandler);
            super.run();
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new RestoreGridStatusCommand();
            instance.designModel = new MosaicDesignModelSupport();
            instance.specModel = nice(IMosaicSpecModel);
            instance.designToColorsTranslator = new DesignToColorsTranslator();
            instance.tileSupplies = new TileSuppliesModelSupport();

            instance.designModel.loadDesign(DESIGN);
            stub(instance.specModel).property("defaultTileColor").returns(DEFAULT_COLOR);
            stub(instance.specModel).property("groutColor").returns(GROUT_COLOR);
            instance.tileSupplies.supplyList = TILE_SUPPLIES;

            instance.eventDispatcher = new EventDispatcher();

        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is RestoreGridStatusCommand", instance is RestoreGridStatusCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_execute_dispatches_DESIGN_COLORS_CHANGED_event_with_processed_grid():void
        {
            var handler:Function = addAsync(check_execute_dispatches_DESIGN_COLORS_CHANGED_event_with_processed_grid, 50);
            instance.eventDispatcher.addEventListener(DesignEvent.DESIGN_COLORS_CHANGED, handler);

            instance.execute();
        }

        private function check_execute_dispatches_DESIGN_COLORS_CHANGED_event_with_processed_grid(e:DesignEvent):void
        {
            assertEqualsVectors('event carries processed design', PROCESSED_DESIGN, e.colors);
        }

        public function test_execute_dispatches_GROUT_COLOR_CHANGED_event_with_grout_color():void
        {
            var handler:Function = addAsync(check_execute_dispatches_GROUT_COLOR_CHANGED_event_with_grout_color, 50);
            instance.eventDispatcher.addEventListener(GroutEvent.COLOR_LOADED, handler);

            instance.execute();
        }

        private function check_execute_dispatches_GROUT_COLOR_CHANGED_event_with_grout_color(e:GroutEvent):void
        {
            assertEquals('event has correct color', GROUT_COLOR, e.color);
        }

        public function test_execute_dispatches_SUPPLY_SELECTED_with_first_tile_supply():void
        {
            var handler:Function = addAsync(check_execute_dispatches_SUPPLY_SELECTED_with_first_tile_supply, 50);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.SELECTED_SUPPLY_COLOR_CHANGED, handler);

            instance.execute();
        }

        private function check_execute_dispatches_SUPPLY_SELECTED_with_first_tile_supply(e:TileSupplyEvent):void
        {
            assertEquals('event has correct color', TILE_COLOR, e.color);

        }
    }
}