package mosaic.controller.commands
{

    import asunit.errors.AssertionFailedError;
    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.errors.VerificationError;
    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.model.ITileSuppliesModel;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class SelectTileSupplyCommandTest extends TestCase
    {
        protected var instance:SelectTileSupplyCommand;
        protected static const ID:uint = 3;

        public function SelectTileSupplyCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(ITileSuppliesModel);
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
            instance = new SelectTileSupplyCommand();
            instance.tileSuppliesModel = nice(ITileSuppliesModel);
            instance.tileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_SELECTED, ID, 0, 0);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is SelectTileSupplyCommand", instance is SelectTileSupplyCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_sets_selectedSupplyID_on_model():void
        {
            instance.execute();
            try
            {
                verify(instance.tileSuppliesModel).setter('selectedSupplyID').args(equalTo(ID));
            }
            catch(verificationError:VerificationError)
            {
                getResult().addFailure(this, new AssertionFailedError(verificationError.message));
            }
        }
    }
}