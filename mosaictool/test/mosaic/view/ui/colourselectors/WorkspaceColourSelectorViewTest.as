package mosaic.view.ui.colorselectors
{

    public class WorkspaceColorSelectorViewTest extends CommonColorSelectorViewTestBase
    {

        public function WorkspaceColorSelectorViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            instance = new WorkspaceColorSelectorView(DEFAULT_COLOR);
            super.setUp();
        }

        public function testInstantiated():void
        {
            assertTrue("instance is WorkspaceColorSelectorView", instance is WorkspaceColorSelectorView);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}