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

    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.model.IMosaicSpecModel;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class ChangeDefaultTileColorCommandTest extends TestCase
    {
        protected var instance:ChangeDefaultTileColorCommand;
        protected static const COLOR:uint = 0x445566;

        public function ChangeDefaultTileColorCommandTest(methodName:String = null)
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
            instance = new ChangeDefaultTileColorCommand();
            instance.defaultColorChangeEvent = new TileColorChangeEvent(TileColorChangeEvent.DEFAULT_CHANGED, 0, 0, COLOR);
            instance.specModel = nice(IMosaicSpecModel);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is ChangeDefaultTileColorCommand", instance is ChangeDefaultTileColorCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_changes_defaultColor_on_spec():void
        {
            instance.execute();
            try
            {
                verify(instance.specModel).setter('defaultTileColor').args(equalTo(COLOR));
            }
            catch(verificationError:VerificationError)
            {
                getResult().addFailure(this, new AssertionFailedError(verificationError.message));
            }
        }
    }
}