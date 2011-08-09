package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.TileSuppliesCombinedEvent;
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.ITileSuppliesModel;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class CombineTileSupplyCommandTest extends TestCase
    {
        protected var instance:CombineTileSupplyCommand;
        protected static const ID_WAS:uint = 3;
        protected static const ID_NOW:uint = 7;

        public function CombineTileSupplyCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(ITileSuppliesModel, IMosaicDesignModel);
            mockolateMaker.addEventListener(Event.COMPLETE, prepareCompleteHandler);
        }

        protected function prepareCompleteHandler(e:Event):void
        {
            IEventDispatcher(e.target).removeEventListener(Event.COMPLETE, prepareCompleteHandler);
            super.run();
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new CombineTileSupplyCommand();
            instance.tileSuppliesCombinedEvent = new TileSuppliesCombinedEvent(TileSuppliesCombinedEvent.SUPPLIES_COMBINED, ID_WAS, ID_NOW);
            instance.tileSuppliesModel = nice(ITileSuppliesModel);
            instance.designModel = nice(IMosaicDesignModel);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is CombineTileSupplyCommand", instance is CombineTileSupplyCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_execute_combinesSupplies_on_tileSuppliesModel():void
        {
            instance.execute();
            verify(instance.tileSuppliesModel).method("combineSupplies").args(equalTo(ID_WAS), equalTo(ID_NOW));
        }

        public function test_execute_switchesColors_on_designModel():void
        {
            instance.execute();
            verify(instance.designModel).method("switchTileColors").args(equalTo(ID_WAS), equalTo(ID_NOW));
        }
    }
}