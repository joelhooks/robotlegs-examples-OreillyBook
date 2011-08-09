package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.model.IConfigModel;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class UpdateCurrentDesignOnConfigCommandTest extends TestCase
    {
        protected var instance:UpdateCurrentDesignOnConfigCommand;

        protected static const DESIGN_NAME:String = "Some design";

        public function UpdateCurrentDesignOnConfigCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IConfigModel);
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
            instance = new UpdateCurrentDesignOnConfigCommand();
            instance.namedDesignEvent = new DesignCreationEvent(DesignCreationEvent.DESIGN_CREATED, 0, 0, DESIGN_NAME);
            instance.configModel = nice(IConfigModel);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is UpdateCurrentDesignOnConfigCommand", instance is UpdateCurrentDesignOnConfigCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_sets_current_Design_on_config_model():void
        {
            instance.execute();
            verify(instance.configModel).setter("currentDesign").args(equalTo(DESIGN_NAME));
        }
    }
}