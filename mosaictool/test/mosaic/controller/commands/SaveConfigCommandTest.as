package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.model.values.ConfigName;
    import mosaic.services.config.IMosaicConfigSavingService;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class SaveConfigCommandTest extends TestCase
    {
        protected var instance:SaveConfigCommand;
        protected static const CONFIG_NAME:String = "Some config";

        public function SaveConfigCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IMosaicConfigSavingService);
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
            instance = new SaveConfigCommand();
            instance.configName = new ConfigName(CONFIG_NAME);
            instance.configSavingService = nice(IMosaicConfigSavingService);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is SaveConfigCommand", instance is SaveConfigCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_triggers_service_to_save_config_with_correct_name():void
        {
            instance.execute();
            verify(instance.configSavingService).method('saveConfig').args(equalTo(CONFIG_NAME));
        }
    }
}