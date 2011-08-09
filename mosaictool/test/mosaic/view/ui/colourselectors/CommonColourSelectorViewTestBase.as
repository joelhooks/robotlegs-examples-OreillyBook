package mosaic.view.ui.colorselectors
{
    import asunit.errors.AssertionFailedError;
    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.ColorPicker;

    import flash.display.Sprite;
    import flash.events.Event;

    public class CommonColorSelectorViewTestBase extends TestCase
    {
        protected var instance:BaseColorSelectorView;
        protected static const DEFAULT_COLOR:uint = 0xFF0000;
        protected var _visualTest:Boolean;

        public function CommonColorSelectorViewTestBase(methodName:String = null)
        {
            super(methodName);
        }

        override protected function setUp():void
        {
            instance.x = instance.y = 300;
            addChild(instance);
            _visualTest = false;
            super.setUp();
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

        public function testIsSprite():void
        {
            assertTrue("instance is Sprite", instance is Sprite);
        }

        public function test_sets_default_color():void
        {
            addAsync(null, 50, checkColorAfterRendering);
        }

        protected function checkColorAfterRendering(e:Event):void
        {
            try
            {
                assertEquals("Sets default color ", DEFAULT_COLOR, colorPicker.selectedColor);
            }
            catch(assertionFailedError:AssertionFailedError)
            {
                getResult().addFailure(this, assertionFailedError);
            }
        }

        protected function get colorPicker():ColorPicker
        {
            return UnitHelpers.findInstanceOf(instance, ColorPicker);
        }

    }

}