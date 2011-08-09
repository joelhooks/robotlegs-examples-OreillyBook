package mosaic.view.ui.colorselectors
{

    public class DefaultTileColorSelectorViewTest extends CommonColorSelectorViewTestBase
    {

        public function DefaultTileColorSelectorViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            instance = new DefaultTileColorSelectorView(DEFAULT_COLOR);
            super.setUp();
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DefaultTileColorSelectorView", instance is DefaultTileColorSelectorView);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}