package mosaic.services.config
{

    import asunit.framework.TestCase;

    import flash.events.EventDispatcher;
    import flash.net.SharedObject;

    import mosaic.controller.events.MosaicConfigServiceEvent;
    import mosaic.model.ConfigModel;

    import org.robotlegs.mvcs.Actor;

    public class MosaicConfigSolSavingServiceTest extends TestCase
    {
        protected var instance:MosaicConfigSolSavingService;

        protected static const CURRENT_DESIGN:String = 'Design B';
        protected static const DESIGN_NAMES:Vector.<String> = Vector.<String>(['Design A', CURRENT_DESIGN, 'Design C']);
        protected static const WORKSPACE_COLOR:uint = 0x339977;
        protected static const SOL_NAME:String = "MosaicSolSaveOK";

        public function MosaicConfigSolSavingServiceTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            wipeSol();

            instance = new MosaicConfigSolSavingService();
            instance.eventDispatcher = new EventDispatcher();
            instance.configModel = new ConfigModel();
            instance.configModel.eventDispatcher = instance.eventDispatcher;
            instance.configModel.designNames = DESIGN_NAMES.slice();
            instance.configModel.currentDesign = CURRENT_DESIGN;
            instance.configModel.workspaceColor = WORKSPACE_COLOR;
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is MosaicConfigSolSavingService", instance is MosaicConfigSolSavingService);
        }

        public function testIsService():void
        {
            assertTrue("instance is robotlegs Actor", instance is Actor);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_saveConfig_writes_workspaceColor_to_sol():void
        {
            instance.saveConfig(SOL_NAME);
            var solData:Object = getSolData();
            assertEquals("SaveConfig writes workspaceColor to sol", WORKSPACE_COLOR, solData.workspaceColor);
        }

        public function test_saveConfig_writes_currentDesign_to_sol():void
        {
            instance.saveConfig(SOL_NAME);
            var solData:Object = getSolData();
            assertEquals("SaveConfig writes currentDesign to sol", CURRENT_DESIGN, solData.currentDesign);
        }

        public function test_saveConfig_writes_designNames_to_sol():void
        {
            instance.saveConfig(SOL_NAME);
            var solData:Object = getSolData();
            assertEqualsVectors("SaveConfig writes designNames to sol", DESIGN_NAMES, solData.designNames);
        }

        public function test_saveConfig_fires_save_completed():void
        {
            var handler:Function = addAsync(check_saveConfig_fires_save_completed, 50);
            instance.eventDispatcher.addEventListener(MosaicConfigServiceEvent.SAVE_COMPLETED, handler);

            instance.saveConfig(SOL_NAME);
        }

        protected function check_saveConfig_fires_save_completed(e:MosaicConfigServiceEvent):void
        {
            assertEquals('event is correct type', MosaicConfigServiceEvent.SAVE_COMPLETED, e.type);
        }

        protected function wipeSol():void
        {
            var sol:SharedObject = SharedObject.getLocal(SOL_NAME);
            sol.clear();
        }

        protected function getSolData():Object
        {
            var sol:SharedObject = SharedObject.getLocal(SOL_NAME);
            return sol.data;
        }

    }
}