package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.stub;

    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.model.IConfigModel;

    import org.robotlegs.mvcs.Command;

    public class RequestLoadFirstDesignCommandTest extends TestCase
    {
        protected var instance:RequestLoadFirstDesignCommand;
        protected static const CURRENT_DESIGN:String = "current design";

        public function RequestLoadFirstDesignCommandTest(methodName:String = null)
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
            instance = new RequestLoadFirstDesignCommand();
            instance.eventDispatcher = new EventDispatcher();
            instance.configModel = nice(IConfigModel);
            stub(instance.configModel).property('currentDesign').returns(CURRENT_DESIGN);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is RequestLoadFirstDesignCommand", instance is RequestLoadFirstDesignCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_dispatches_load_request_with_current_design():void
        {
            var handler:Function = addAsync(check_dispatches_load_request_with_current_design, 50);
            instance.eventDispatcher.addEventListener(DesignLoadEvent.LOAD_REQUESTED, handler);

            instance.execute();
        }

        private function check_dispatches_load_request_with_current_design(e:DesignLoadEvent):void
        {
            assertEquals("event has current design", CURRENT_DESIGN, e.designName);
        }
    }
}