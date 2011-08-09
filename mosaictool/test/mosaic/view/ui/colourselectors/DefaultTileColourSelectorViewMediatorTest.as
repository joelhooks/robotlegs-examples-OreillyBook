package mosaic.view.ui.colorselectors
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.ColorPicker;

    import flash.events.Event;
    import flash.events.EventDispatcher;

    import mosaic.controller.events.TileColorChangeEvent;

    import org.robotlegs.mvcs.Mediator;

    public class DefaultTileColorSelectorViewMediatorTest extends TestCase
    {
        protected var instance:DefaultTileColorSelectorViewMediator;
        protected static const CHANGED_COLOR:uint = 0x330000;

        public function DefaultTileColorSelectorViewMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DefaultTileColorSelectorViewMediator();
            instance.view = new DefaultTileColorSelectorView(0);
            addChild(instance.view);
            instance.setViewComponent(instance.view);
            instance.eventDispatcher = new EventDispatcher();
            instance.onRegister();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            removeChild(instance.view);
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is DefaultTileColorSelectorViewMediator", instance is DefaultTileColorSelectorViewMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_dispatches_TileColorChangeEvent_COLOR_CHANGED_when_colorPicker_fires_change():void
        {
            addAsync(null, 50, dispatchColorChangeAfterRendering);
        }

        protected function dispatchColorChangeAfterRendering(e:Event):void
        {
            var handler:Function = addAsync(check_dispatches_TileColorChangeEvent_DEFAULT_CHANGED_when_colorPicker_fires_change, 150);
            instance.eventDispatcher.addEventListener(TileColorChangeEvent.DEFAULT_CHANGED, handler);


            colorPicker.selectedColor = CHANGED_COLOR;
            colorPicker.dispatchEvent(new Event(Event.CHANGE));
        }

        protected function check_dispatches_TileColorChangeEvent_DEFAULT_CHANGED_when_colorPicker_fires_change(e:TileColorChangeEvent):void
        {
            assertEquals("correct color is sent", CHANGED_COLOR, e.color);
        }

        public function test_changes_color_to_match_when_COLOR_LOADED_received():void
        {
            addAsync(null, 50, dispatchColorLoadedAfterRendering_verify_color_passed_to_view);
        }

        protected function dispatchColorLoadedAfterRendering_verify_color_passed_to_view(e:Event):void
        {
            var evt:TileColorChangeEvent = new TileColorChangeEvent(TileColorChangeEvent.DEFAULT_LOADED, 0, 0, CHANGED_COLOR);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("color has been passed to view", CHANGED_COLOR, colorPicker.selectedColor);
        }


        protected function get colorPicker():ColorPicker
        {
            return UnitHelpers.findInstanceOf(instance.view, ColorPicker);
        }

    }
}