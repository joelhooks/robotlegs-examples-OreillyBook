package mosaic.view.ui.buttons
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.DesignSaveEvent;

    import org.robotlegs.mvcs.Mediator;

    public class SaveAsButtonMediatorTest extends TestCase
    {
        protected var instance:SaveAsButtonMediator;

        public function SaveAsButtonMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new SaveAsButtonMediator();
            instance.view = new SaveAsButton();
            instance.setViewComponent(instance.view);
            instance.eventDispatcher = new EventDispatcher();
            instance.onRegister();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is SaveAsButtonMediator", instance is SaveAsButtonMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_click_on_view_dispatches_SAVE_REQUESTED_event():void
        {
            var handler:Function = addAsync(check_click_on_view_dispatches_SAVE_AS_REQUESTED_event, 50);
            instance.eventDispatcher.addEventListener(DesignSaveEvent.SAVE_AS_REQUESTED, handler);

            UnitHelpers.clickItem(instance.view);
        }

        protected function check_click_on_view_dispatches_SAVE_AS_REQUESTED_event(e:DesignSaveEvent):void
        {
            assertEquals('event is correct type', DesignSaveEvent.SAVE_AS_REQUESTED, e.type);
        }

    }
}