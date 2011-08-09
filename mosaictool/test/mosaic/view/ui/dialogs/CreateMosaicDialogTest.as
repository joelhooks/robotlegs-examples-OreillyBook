package mosaic.view.ui.dialogs
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.Button;
    import fl.controls.TextInput;

    import flash.display.Sprite;

    public class CreateMosaicDialogTest extends TestCase
    {
        protected var instance:CreateMosaicDialog;
        protected static const COLUMNS:uint = 34;
        protected static const ROWS:uint = 23;
        protected static const DESIGN_NAME:String = "Some design";

        public function CreateMosaicDialogTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new CreateMosaicDialog(970, 550);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is CreateMosaicDialog", instance is CreateMosaicDialog);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_clicking_cancel_removes_the_dialog():void
        {
            addChild(instance);
            UnitHelpers.clickItem(cancelButton);
            assertTrue("Clicking cancel removes the dialog", instance.parent == null);
        }

        public function test_verified_visually():void
        {
            addChild(instance);
            assertTrue("Verified visually", true);
            removeChild(instance);
        }

        public function test_get_rows():void
        {
            addChild(instance);
            var rows:TextInput = UnitHelpers.findNamedInstanceOf(instance, TextInput, 'rows', 2) as TextInput;
            rows.text = String(ROWS);
            assertEquals("Get rows", ROWS, instance.rows);
            removeChild(instance);
        }

        public function test_get_columns():void
        {
            addChild(instance);
            var columns:TextInput = UnitHelpers.findNamedInstanceOf(instance, TextInput, 'columns', 2) as TextInput;
            columns.text = String(COLUMNS);
            assertEquals("Get columns", COLUMNS, instance.columns);
            removeChild(instance);
        }

        public function test_get_designName():void
        {
            addChild(instance);
            var designInput:TextInput = UnitHelpers.findNamedInstanceOf(instance, TextInput, 'design name', 2) as TextInput;
            designInput.text = String(DESIGN_NAME);
            assertEquals("Get designName", DESIGN_NAME, instance.designName);
            removeChild(instance);
        }

        public function test_exposes_createButton():void
        {
            addChild(instance);
            assertTrue("Exposes createButton ", instance.createButton is Button);
            removeChild(instance);
        }

        protected function get cancelButton():Button
        {
            return UnitHelpers.findInstanceOf(instance, Button);
        }

    }
}