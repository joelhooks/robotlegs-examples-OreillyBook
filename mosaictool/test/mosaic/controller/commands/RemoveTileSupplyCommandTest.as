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

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class RemoveTileSupplyCommandTest extends TestCase
    {
        protected var instance:RemoveTileSupplyCommand;
        protected static const ID:uint = 4;
        protected static const COLOR:uint = 0x887766;
        protected static const COUNT:Number = 0;

        public function RemoveTileSupplyCommandTest(methodName:String = null)
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
            instance = new RemoveTileSupplyCommand();
            instance.tileSuppliesModel = nice(ITileSuppliesModel);
            instance.tileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_DELETED, ID, COLOR, COUNT);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is RemoveTileSupplyCommand", instance is RemoveTileSupplyCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_calls_removeSupply_with_id_from_event():void
        {
            instance.execute();
            verify(instance.tileSuppliesModel).method("removeSupply").args(equalTo(ID));
        }
    }
}