package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.GroutEvent;
    import mosaic.model.IMosaicSpecModel;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class ChangeGroutColorCommandTest extends TestCase
    {
        protected var instance:ChangeGroutColorCommand;
        protected static const COLOR:uint = 0x334455;

        public function ChangeGroutColorCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IMosaicSpecModel);
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
            instance = new ChangeGroutColorCommand();
            instance.groutEvent = new GroutEvent(GroutEvent.COLOR_CHANGED, COLOR);
            instance.mosaicSpecModel = nice(IMosaicSpecModel);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is ChangeGroutColorCommand", instance is ChangeGroutColorCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_sets_grout_color():void
        {
            instance.execute();
            verify(instance.mosaicSpecModel).setter("groutColor").args(equalTo(COLOR));
        }
    }
}