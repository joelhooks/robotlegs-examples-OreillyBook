package mosaic.view.ui.colorselectors
{

    public class GroutSelectorViewTest extends CommonColorSelectorViewTestBase
    {

        public function GroutSelectorViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            instance = new GroutSelectorView(DEFAULT_COLOR);
            super.setUp();
        }

        public function testInstantiated():void
        {
            assertTrue("instance is GroutSelectorView", instance is GroutSelectorView);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }
    }
}