package mosaic.view.ui.buttons
{

    import asunit.framework.TestCase;

    import flash.display.Sprite;

    public class SaveAsButtonTest extends TestCase
    {
        protected var instance:SaveAsButton;

        public function SaveAsButtonTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new SaveAsButton();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is SaveAsButton", instance is SaveAsButton);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}