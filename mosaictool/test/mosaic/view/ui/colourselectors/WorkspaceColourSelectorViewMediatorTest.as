package mosaic.view.ui.colorselectors
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.ColorPicker;

    import flash.events.Event;
    import flash.events.EventDispatcher;

    import mosaic.controller.events.WorkspaceColorEvent;

    import org.robotlegs.mvcs.Mediator;

    public class WorkspaceColorSelectorViewMediatorTest extends TestCase
    {
        protected var instance:WorkspaceColorSelectorViewMediator;
        protected static const CHANGED_COLOR:uint = 0x339955;

        public function WorkspaceColorSelectorViewMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new WorkspaceColorSelectorViewMediator();
            instance.view = new WorkspaceColorSelectorView(0);
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
            assertTrue("instance is WorkspaceColorSelectorViewMediator", instance is WorkspaceColorSelectorViewMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_dispatches_GroutEvent_COLOR_CHANGED_when_colorPicker_fires_change():void
        {
            addAsync(null, 50, dispatchColorChangeAfterRendering);
        }

        protected function dispatchColorChangeAfterRendering(e:Event):void
        {
            var handler:Function = addAsync(check_dispatches_WorkspaceColorEvent_COLOR_CHANGED_when_colorPicker_fires_change, 150);
            instance.eventDispatcher.addEventListener(WorkspaceColorEvent.COLOR_CHANGED, handler);


            colorPicker.selectedColor = CHANGED_COLOR;
            colorPicker.dispatchEvent(new Event(Event.CHANGE));
        }

        protected function check_dispatches_WorkspaceColorEvent_COLOR_CHANGED_when_colorPicker_fires_change(e:WorkspaceColorEvent):void
        {
            assertEquals("correct color is sent", CHANGED_COLOR, e.color);
        }

        public function test_changes_color_to_match_when_COLOR_LOADED_received():void
        {
            addAsync(null, 50, dispatchColorLoadedAfterRendering_verify_color_passed_to_view);
        }

        protected function dispatchColorLoadedAfterRendering_verify_color_passed_to_view(e:Event):void
        {
            var evt:WorkspaceColorEvent = new WorkspaceColorEvent(WorkspaceColorEvent.COLOR_LOADED, CHANGED_COLOR);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("color has been passed to view", CHANGED_COLOR, colorPicker.selectedColor);
        }


        protected function get colorPicker():ColorPicker
        {
            return UnitHelpers.findInstanceOf(instance.view, ColorPicker);
        }

    }
}