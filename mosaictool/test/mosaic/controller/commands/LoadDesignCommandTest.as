package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.services.design.IDesignLoadingService;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class LoadDesignCommandTest extends TestCase
    {
        protected var instance:LoadDesignCommand;

        protected static const DESIGN_NAME:String = "DesignName";

        public function LoadDesignCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IDesignLoadingService);
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
            instance = new LoadDesignCommand();
            instance.designLoadEvent = new DesignLoadEvent(DesignLoadEvent.LOAD_REQUESTED, DESIGN_NAME);
            instance.designLoadingService = nice(IDesignLoadingService);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is LoadDesignCommand", instance is LoadDesignCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_execute_calls_on_service_with_correct_designName():void
        {
            instance.execute();
            verify(instance.designLoadingService).method("loadDesign").args(equalTo(DESIGN_NAME));
        }

    }
}