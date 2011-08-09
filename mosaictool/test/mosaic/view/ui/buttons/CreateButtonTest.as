package mosaic.view.ui.buttons
{

    import asunit.framework.TestCase;

    import flash.display.Sprite;

    public class CreateButtonTest extends TestCase
    {
        protected var instance:CreateButton;

        public function CreateButtonTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new CreateButton();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is CreateButton", instance is CreateButton);
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