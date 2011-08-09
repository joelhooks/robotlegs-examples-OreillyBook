package mosaic.model
{

    import asunit.framework.TestCase;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.ConfigChangedEvent;
    import mosaic.controller.events.DesignListEvent;

    public class ConfigModelTest extends TestCase
    {
        protected var instance:ConfigModel;

        protected static const DESIGN_NAMES:Vector.<String> = Vector.<String>(['Design 1', 'Design 2']);
        protected static const CURRENT_DESIGN:String = "Design 1";
        protected static const NEW_DESIGN:String = "New Design";
        protected static const WORKSPACE_COLOR:uint = 0xFF0000;

        public function ConfigModelTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new ConfigModel();
            instance.eventDispatcher = new EventDispatcher();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is ConfigModel", instance is ConfigModel);
        }

        public function test_implements_interface():void
        {
            assertTrue("Implements interface", instance is IConfigModel);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_set_designNames():void
        {
            instance.designNames = DESIGN_NAMES.slice();
            assertEqualsVectors("Set designNames", DESIGN_NAMES, instance.designNames);
        }

        public function test_get_hasDesign_returns_true_if_designNames_set():void
        {
            instance.designNames = DESIGN_NAMES.slice();
            assertTrue("Get hasDesign returns true if designNames set", instance.hasDesign);
        }

        public function test_get_hasDesign_returns_false_if_designNames_not_set():void
        {
            assertFalse("Get hasDesign returns false if designNames not set", instance.hasDesign);
        }

        public function test_set_currentDesign_if_not_new_returns_item_expected():void
        {
            instance.designNames = DESIGN_NAMES.slice();
            instance.currentDesign = CURRENT_DESIGN;
            assertEquals("Set currentDesign", CURRENT_DESIGN, instance.currentDesign);
        }

        public function test_set_workspaceColor():void
        {
            instance.workspaceColor = WORKSPACE_COLOR;
            assertEquals("Set workspaceColor", WORKSPACE_COLOR, instance.workspaceColor);
        }

        public function test_if_current_design_is_new_appends_it_to_list():void
        {
            var expectedDesignNames:Vector.<String> = DESIGN_NAMES.slice();
            expectedDesignNames.push(NEW_DESIGN);

            instance.designNames = DESIGN_NAMES.slice();
            instance.currentDesign = NEW_DESIGN;

            assertEqualsVectors("If current design is new appends it to list", expectedDesignNames, instance.designNames);
        }

        public function test_if_current_design_is_not_new_list_remains_same():void
        {
            instance.designNames = DESIGN_NAMES.slice();
            instance.currentDesign = CURRENT_DESIGN;

            assertEqualsVectors("If current design is new appends it to list", DESIGN_NAMES, instance.designNames);
        }

        public function test_set_currentDesign_if_new_returns_item_expected():void
        {
            instance.designNames = DESIGN_NAMES.slice();
            instance.currentDesign = NEW_DESIGN;
            assertEquals("Set currentDesign", NEW_DESIGN, instance.currentDesign);
        }

        public function test_set_currentDesign_fires_changed():void
        {
            instance.designNames = DESIGN_NAMES.slice();
            var handler:Function = addAsync(check_model_fires_changed, 50);
            instance.eventDispatcher.addEventListener(ConfigChangedEvent.CHANGED, handler);

            instance.currentDesign = NEW_DESIGN;
        }

        public function test_set_workspaceColor_fires_changed():void
        {
            var handler:Function = addAsync(check_model_fires_changed, 50);
            instance.eventDispatcher.addEventListener(ConfigChangedEvent.CHANGED, handler);

            instance.workspaceColor = WORKSPACE_COLOR;
        }

        private function check_model_fires_changed(e:ConfigChangedEvent):void
        {
            assertEquals('event is correct type', ConfigChangedEvent.CHANGED, e.type);
        }

        public function test_setting_Design_list_fires_DesignListEvent_CHANGED():void
        {
            var handler:Function = addAsync(check_setting_Design_list_fires_DesignListEvent_CHANGED, 50);
            instance.eventDispatcher.addEventListener(DesignListEvent.CHANGED, handler);

            instance.designNames = DESIGN_NAMES.slice();
        }

        private function check_setting_Design_list_fires_DesignListEvent_CHANGED(e:DesignListEvent):void
        {
            assertEqualsVectors("passes design list correctly", DESIGN_NAMES, e.designList);

        }

        public function test_adding_new_Design_fires_DesignListEvent_CHANGED():void
        {
            instance.designNames = DESIGN_NAMES.slice();

            var handler:Function = addAsync(check_adding_new_Design_fires_DesignListEvent_CHANGED, 50);
            instance.eventDispatcher.addEventListener(DesignListEvent.CHANGED, handler);
            instance.currentDesign = NEW_DESIGN;
        }

        private function check_adding_new_Design_fires_DesignListEvent_CHANGED(e:DesignListEvent):void
        {
            var expectedDesignNames:Vector.<String> = DESIGN_NAMES.slice();
            expectedDesignNames.push(NEW_DESIGN);

            assertEqualsVectors("passes design list correctly", expectedDesignNames, e.designList);
        }

    }
}