package mosaic.view.ui.dialogs
{

    import asunit.framework.TestCase;

    import flash.display.Sprite;

    public class SaveAsDialogTest extends TestCase
    {
        protected var instance:SaveAsDialog;

        public function SaveAsDialogTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new SaveAsDialog(970, 550);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is SaveAsDialog", instance is SaveAsDialog);
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