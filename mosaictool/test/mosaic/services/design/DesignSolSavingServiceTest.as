package mosaic.services.design
{
    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.net.SharedObject;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.DesignSaveEvent;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Actor;

    public class DesignSolSavingServiceTest extends TestCase
    {
        protected var instance:DesignSolSavingService;
        protected static const DESIGN_NAME:String = "GoodDesign";

        public function DesignSolSavingServiceTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IDesignToDataParser);
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
            clearSol();
            instance = new DesignSolSavingService();
            instance.designToDataParser = nice(IDesignToDataParser);
            instance.eventDispatcher = new EventDispatcher();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignSolSavingService", instance is DesignSolSavingService);
        }

        public function test_implements_interface():void
        {
            assertTrue("Implements interface", instance is IDesignSavingService);
        }

        public function testIsService():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_writes_sol_with_correct_name():void
        {
            instance.saveDesign(DESIGN_NAME);

            var sol:SharedObject = SharedObject.getLocal(DESIGN_NAME);
            assertNotNull("Writes sol with correct name", sol.data.date);
        }

        public function test_passes_sol_data_to_parser_to_be_written():void
        {
            instance.saveDesign(DESIGN_NAME);

            var sol:SharedObject = SharedObject.getLocal(DESIGN_NAME);
            var solData:Object = sol.data;

            verify(instance.designToDataParser).method("populateDataFromDesign").args(equalTo(solData));
        }

        public function test_dispatches_save_complete_if_successful():void
        {
            var handler:Function = addAsync(check_dispatches_save_complete_if_successful, 500);
            instance.eventDispatcher.addEventListener(DesignSaveEvent.SAVE_COMPLETED, handler);

            instance.saveDesign(DESIGN_NAME);
        }

        protected function check_dispatches_save_complete_if_successful(e:DesignSaveEvent):void
        {
            assertEquals('event holds correct design name', DESIGN_NAME, e.designName);
        }

        protected function clearSol():void
        {
            var sol:SharedObject = SharedObject.getLocal(DESIGN_NAME);
            sol.clear();
        }

    }
}