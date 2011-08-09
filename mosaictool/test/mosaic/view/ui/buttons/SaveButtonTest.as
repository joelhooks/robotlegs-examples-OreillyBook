package mosaic.view.ui.buttons
{

    import asunit.framework.TestCase;

    import flash.display.Sprite;

    public class SaveButtonTest extends TestCase
    {
        protected var saveButton:SaveButton;

        public function SaveButtonTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            saveButton = new SaveButton();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            saveButton = null;
        }

        public function testInstantiated():void
        {
            assertTrue("saveButton is SaveButton", saveButton is SaveButton);
        }

        public function testIsSprite():void
        {
            assertTrue("saveButton is Sprite", saveButton is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

    }
}