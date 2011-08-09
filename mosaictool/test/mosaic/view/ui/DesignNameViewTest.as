package mosaic.view.ui
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.Label;

    import flash.display.Sprite;

    public class DesignNameViewTest extends TestCase
    {
        protected var instance:DesignNameView;
        protected static const UPDATED_NAME:String = "Some name";

        public function DesignNameViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignNameView();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DesignNameView", instance is DesignNameView);
        }

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_set_title_updates_text():void
        {
            instance.setText(UPDATED_NAME);
            var label:Label = UnitHelpers.findInstanceOf(instance, Label);
            assertEquals("Set title updates text", UPDATED_NAME, label.text);
        }
    }
}