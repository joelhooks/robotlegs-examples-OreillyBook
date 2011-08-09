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
    import mosaic.model.DesignToColorsTranslator;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.MosaicDesignModelSupport;
    import mosaic.model.TileSuppliesModelSupport;
    import mosaic.model.TileSupplyVO;

    import org.robotlegs.mvcs.Command;

    public class RefreshDesignColorsCommandTest extends TestCase
    {
        protected var instance:RefreshDesignColorsCommand;

        protected static const DESIGN:Vector.<Vector.<uint>> = Vector.<Vector.<uint>>([Vector.<uint>([3,0,3])]);
        protected static const TILE_SUPPLIES:Vector.<TileSupplyVO> = Vector.<TileSupplyVO>([new TileSupplyVO(3, 0x000033, 5)]);
        protected static const DEFAULT_COLOR:uint = 0x333333;
        protected static const PROCESSED_DESIGN:Vector.<Vector.<uint>> = Vector.<Vector.<uint>>([Vector.<uint>([0x000033,0x333333,0x000033])]);

        public function RefreshDesignColorsCommandTest(methodName:String = null)
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
            instance = new RefreshDesignColorsCommand();
            instance.designModel = new MosaicDesignModelSupport();
            instance.specModel = nice(IMosaicSpecModel);
            instance.designToColorsTranslator = new DesignToColorsTranslator();
            instance.tileSupplies = new TileSuppliesModelSupport();

            instance.designModel.loadDesign(DESIGN);
            stub(instance.specModel).property("defaultTileColor").returns(DEFAULT_COLOR);
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
            assertTrue("instance is RefreshDesignColorsCommand", instance is RefreshDesignColorsCommand);
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

    }
}