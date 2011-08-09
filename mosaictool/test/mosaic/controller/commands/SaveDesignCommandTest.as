package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.stub;
    import mockolate.verify;

    import mosaic.model.IConfigModel;
    import mosaic.services.design.IDesignSavingService;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class SaveDesignCommandTest extends TestCase
    {
        protected var instance:SaveDesignCommand;

        protected static const DESIGN_NAME:String = "DesignName";

        public function SaveDesignCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IDesignSavingService, IConfigModel);
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
            instance = new SaveDesignCommand();
            instance.configModel = nice(IConfigModel);
            stub(instance.configModel).property("currentDesign").returns(DESIGN_NAME);
            instance.designSavingService = nice(IDesignSavingService);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is SaveDesignCommand", instance is SaveDesignCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_calls_save_service_with_correct_design_name():void
        {
            instance.execute();
            verify(instance.designSavingService).method("saveDesign").args(equalTo(DESIGN_NAME));
        }
    }
}