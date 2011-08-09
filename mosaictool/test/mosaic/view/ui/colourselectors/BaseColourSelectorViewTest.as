package mosaic.view.ui.colorselectors
{

    import asunit.errors.AssertionFailedError;

    import com.newloop.util.UnitHelpers;

    import fl.controls.Label;

    import flash.events.Event;

    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;

    public class BaseColorSelectorViewTest extends CommonColorSelectorViewTestBase
    {

        protected static const LABEL:String = "test label";
        protected static const CHANGED_COLOR:uint = 0x330066;
        protected static const SET_COLOR:uint = 0x999999;

        public function BaseColorSelectorViewTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            instance = new BaseColorSelectorView(LABEL, DEFAULT_COLOR);
            super.setUp()
        }

        public function testInstantiated():void
        {
            assertTrue("instance is BaseColorSelectorView", instance is BaseColorSelectorView);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_sets_label():void
        {
            var labelField:Label = UnitHelpers.findInstanceOf(instance, Label);
            assertEquals("Sets label", LABEL, labelField.text);
        }

        public function test_dispatches_ColorChangeEvent_CHANGED_when_colorPicker_fires_change():void
        {
            addAsync(null, 50, checkColorChangeAfterRendering);
        }

        protected function checkColorChangeAfterRendering(e:Event):void
        {
            var handler:Function = addAsync(check_dispatches_ColorChangeEvent_CHANGED_when_colorPicker_fires_change, 150);
            instance.addEventListener(ColorChangeEvent.CHANGED, handler);

            colorPicker.selectedColor = CHANGED_COLOR;
            colorPicker.dispatchEvent(new Event(Event.CHANGE));
        }

        protected function check_dispatches_ColorChangeEvent_CHANGED_when_colorPicker_fires_change(e:ColorChangeEvent):void
        {
            assertEquals("correct color is sent", CHANGED_COLOR, e.color);
        }

        public function test_set_selectedColor():void
        {
            addAsync(null, 50, checkSetColorAfterRendering)
        }

        protected function checkSetColorAfterRendering(e:Event):void
        {
            try
            {
                instance.selectedColor = SET_COLOR;
                assertEquals("Set color", SET_COLOR, instance.selectedColor);
            }
            catch(assertionFailedError:AssertionFailedError)
            {
                getResult().addFailure(this, assertionFailedError);
            }
        }
    }
}