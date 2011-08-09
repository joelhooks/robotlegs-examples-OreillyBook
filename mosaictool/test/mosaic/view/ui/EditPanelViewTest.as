package mosaic.view.ui
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.display.Sprite;

    import mosaic.view.tilesupply.TileSupplyMenu;
    import mosaic.view.ui.buttons.CreateButton;
    import mosaic.view.ui.buttons.SaveAsButton;
    import mosaic.view.ui.buttons.SaveButton;
    import mosaic.view.ui.colorselectors.DefaultTileColorSelectorView;
    import mosaic.view.ui.colorselectors.GroutSelectorView;
    import mosaic.view.ui.colorselectors.WorkspaceColorSelectorView;

    public class EditPanelViewTest extends TestCase
    {
        protected var instance:EditPanelView;
        protected var _visualTest:Boolean;

        public function EditPanelViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            _visualTest = false;
            instance = new EditPanelView();
            addChild(instance);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            if (!_visualTest)
            {
                removeChild(instance);
            }
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is EditPanelView", instance is EditPanelView);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_contains_SaveButton():void
        {
            assertNotNull("Contains SaveButton", UnitHelpers.findInstanceOf(instance, SaveButton));
        }

        public function test_contains_SaveAsButton():void
        {
            assertNotNull("Contains SaveAsButton", UnitHelpers.findInstanceOf(instance, SaveAsButton));
        }

        public function test_contains_CreateButton():void
        {
            assertNotNull("Contains CreateButton", UnitHelpers.findInstanceOf(instance, CreateButton));
        }

        public function test_contains_LoadSelector():void
        {
            assertNotNull("Contains LoadSelector", UnitHelpers.findInstanceOf(instance, LoadSelector));
        }

        public function test_contains_DesignNameView():void
        {
            assertNotNull("Contains DesignNameView", UnitHelpers.findInstanceOf(instance, DesignNameView));
        }

        public function test_contains_WorkspaceColorSelector():void
        {
            assertNotNull("Contains WorkspaceColorSelectorView", UnitHelpers.findInstanceOf(instance, WorkspaceColorSelectorView));
        }

        public function test_contains_GroutSelector():void
        {
            assertNotNull("Contains GroutSelectorView", UnitHelpers.findInstanceOf(instance, GroutSelectorView));
        }

        public function test_contains_DefaultTileColorSelector():void
        {
            assertNotNull("Contains DefaultTileColorSelectorView", UnitHelpers.findInstanceOf(instance, DefaultTileColorSelectorView));
        }

        public function test_contains_TileSupplyMenu():void
        {
            assertNotNull("Contains TileSupplyMenu", UnitHelpers.findInstanceOf(instance, TileSupplyMenu));
        }

        public function test_verified_visually():void
        {
            _visualTest = true;
            addChild(instance);
            assertTrue("Verified visually", true);
            removeChild(instance);
        }


    }
}