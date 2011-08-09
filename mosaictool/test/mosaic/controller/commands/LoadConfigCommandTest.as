package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.model.values.ConfigName;
    import mosaic.services.config.IMosaicConfigLoadingService;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class LoadConfigCommandTest extends TestCase
    {
        protected var instance:LoadConfigCommand;
        protected static const CONFIG_NAME:String = "A config name";

        public function LoadConfigCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IMosaicConfigLoadingService);
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
            instance = new LoadConfigCommand();
            instance.configName = new ConfigName(CONFIG_NAME);
            instance.configLoadingService = nice(IMosaicConfigLoadingService);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is LoadConfigCommand", instance is LoadConfigCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_calls_loadConfig_on_service_passing_CONFIG_NAME():void
        {
            instance.execute();
            verify(instance.configLoadingService).method("loadConfig").args(equalTo(CONFIG_NAME));
        }

    }
}