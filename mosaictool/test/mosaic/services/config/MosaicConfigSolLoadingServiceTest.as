package mosaic.services.config
{

    import asunit.framework.TestCase;

    import flash.events.EventDispatcher;
    import flash.net.SharedObject;

    import mosaic.controller.events.MosaicConfigServiceEvent;
    import mosaic.model.ConfigModel;

    import org.robotlegs.mvcs.Actor;

    public class MosaicConfigSolLoadingServiceTest extends TestCase
    {
        protected var instance:MosaicConfigSolLoadingService;
        protected static const NON_EXISTANT_CONFIG:String = "MosaicConfigThatIsntThere";
        protected static const GOOD_CONFIG:String = "MosaicConfigGood";
        protected static const BAD_CONFIG:String = "MosaicConfigBad";
        protected static const DESIGN_NAMES:Vector.<String> = Vector.<String>(['Design 1', 'Design 2']);
        protected static const CURRENT_DESIGN:String = "Design 2";
        protected static const WORKSPACE_COLOR:uint = 0x330033;

        public function MosaicConfigSolLoadingServiceTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            writeConfigs();
            instance = new MosaicConfigSolLoadingService();
            instance.eventDispatcher = new EventDispatcher();
            instance.configModel = new ConfigModel();
            instance.configModel.eventDispatcher = instance.eventDispatcher;
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is MosaicConfigSolLoadingService", instance is MosaicConfigSolLoadingService);
        }

        public function testIsService():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function test_implements_IMosaicConfigLoadingService():void
        {
            assertTrue("Implements IMosaicConfigLoadingService ", instance is IMosaicConfigLoadingService);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_when_configSOL_not_found_dispatches_CONFIG_NOT_FOUND():void
        {
            var handler:Function = addAsync(check_when_configSOL_not_found_dispatches_CONFIG_NOT_FOUND, 50);
            instance.eventDispatcher.addEventListener(MosaicConfigServiceEvent.CONFIG_NOT_FOUND, handler);

            instance.loadConfig(NON_EXISTANT_CONFIG);
        }

        protected function check_when_configSOL_not_found_dispatches_CONFIG_NOT_FOUND(e:MosaicConfigServiceEvent):void
        {
            assertEquals('event is correct type', MosaicConfigServiceEvent.CONFIG_NOT_FOUND, e.type);
        }

        public function test_when_configSOL_found_updates_model_with_design_names():void
        {
            instance.loadConfig(GOOD_CONFIG);
            assertEqualsVectors('config updated with designNames', DESIGN_NAMES, instance.configModel.designNames)
        }

        public function test_when_configSOL_found_updates_model_with_currentDesign():void
        {
            instance.loadConfig(GOOD_CONFIG);
            assertEquals('config updated with currentDesign', CURRENT_DESIGN, instance.configModel.currentDesign);
        }

        public function test_when_configSOL_found_updates_model_with_workspaceColor():void
        {
            instance.loadConfig(GOOD_CONFIG);
            assertEquals("config updated with workspaceColor", WORKSPACE_COLOR, instance.configModel.workspaceColor);
        }

        public function test_when_configSOL_found_dispatches_loaded():void
        {
            var handler:Function = addAsync(check_when_configSOL_found_dispatches_loaded, 1000);
            instance.eventDispatcher.addEventListener(MosaicConfigServiceEvent.LOAD_COMPLETED, handler);

            instance.loadConfig(GOOD_CONFIG);
        }

        protected function check_when_configSOL_found_dispatches_loaded(e:MosaicConfigServiceEvent):void
        {
            assertEquals("config updated before event sent", WORKSPACE_COLOR, instance.configModel.workspaceColor);
        }

        public function test_when_bad_configSOL_found_dispatches_failed():void
        {
            var handler:Function = addAsync(check_when_bad_configSOL_found_dispatches_failed, 1000);
            instance.eventDispatcher.addEventListener(MosaicConfigServiceEvent.LOAD_FAILED, handler);

            instance.loadConfig(BAD_CONFIG);
        }

        protected function check_when_bad_configSOL_found_dispatches_failed(e:MosaicConfigServiceEvent):void
        {
            assertFalse("config not updated before event sent", instance.configModel.hasDesign);
        }

        protected function writeGoodConfig():void
        {
            var sol:SharedObject = SharedObject.getLocal(GOOD_CONFIG);
            sol.data.designNames = DESIGN_NAMES;
            sol.data.currentDesign = CURRENT_DESIGN;
            sol.data.workspaceColor = WORKSPACE_COLOR;

            sol.flush();
        }

        protected function writeBadConfig():void
        {
            var sol:SharedObject = SharedObject.getLocal(BAD_CONFIG);
            sol.data.designNames = DESIGN_NAMES;

            sol.flush();
        }

        protected function writeConfigs():void
        {
            writeGoodConfig();
            writeBadConfig();
        }
    }
}