package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.model.ITileSuppliesModel;
    import mosaic.model.utils.AutoIncrementor;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class AddTileSupplyCommandTest extends TestCase
    {
        protected var instance:AddTileSupplyCommand;
        protected static const ID:uint = 3;
        protected static const COLOR:uint = 0x334455;

        public function AddTileSupplyCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(ITileSuppliesModel);
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
            instance = new AddTileSupplyCommand();
            instance.tileSuppliesModel = nice(ITileSuppliesModel);
            instance.tileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_ADDITION_REQUESTED, 0, COLOR, 0);
            instance.tileSupplyIndexAutoIncrementor = new AutoIncrementor();
            instance.tileSupplyIndexAutoIncrementor.currentIndex = ID - 1;
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is AddTileSupplyCommand", instance is AddTileSupplyCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute():void
        {
            instance.execute();
            verify(instance.tileSuppliesModel).method("addSupply").args(equalTo(ID), equalTo(COLOR));
        }

    }
}