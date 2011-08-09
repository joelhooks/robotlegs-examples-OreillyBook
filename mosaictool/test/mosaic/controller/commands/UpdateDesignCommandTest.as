package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.stub;
    import mockolate.verify;

    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.ITileSuppliesModel;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class UpdateDesignCommandTest extends TestCase
    {
        protected var instance:UpdateDesignCommand;
        protected static const ROW:uint = 5;
        protected static const COLUMN:uint = 7;
        protected static const COLOR:uint = 0x333333;
        protected static const ID_WAS:uint = 2;
        protected static const ID_NOW:uint = 4;

        public function UpdateDesignCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IMosaicDesignModel, ITileSuppliesModel);
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
            instance = new UpdateDesignCommand();
            instance.designModel = nice(IMosaicDesignModel);
            instance.tileColorChangeEvent = new TileColorChangeEvent(TileColorChangeEvent.CHANGED, ROW, COLUMN, COLOR);
            instance.tileSuppliesModel = nice(ITileSuppliesModel);
            stub(instance.tileSuppliesModel).property("selectedSupplyID").returns(ID_NOW);
            stub(instance.designModel).method("changeTileColorAt").returns(ID_WAS);
            instance.eventDispatcher = new EventDispatcher();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is UpdateDesignCommand", instance is UpdateDesignCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_updates_model():void
        {
            instance.execute();
            verify(instance.designModel).method("changeTileColorAt").args(equalTo(ROW), equalTo(COLUMN), equalTo(ID_NOW));
        }

        public function test_execute_updates_tileSupplies():void
        {
            instance.execute();
            verify(instance.tileSuppliesModel).method("switchTiles").args(equalTo(ID_WAS), equalTo(ID_NOW));
        }
    }
}