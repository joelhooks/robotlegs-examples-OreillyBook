package mosaic.view.ui.buttons
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.CreateMosaicEvent;

    import org.robotlegs.mvcs.Mediator;

    public class CreateButtonMediatorTest extends TestCase
    {
        protected var instance:CreateButtonMediator;

        public function CreateButtonMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new CreateButtonMediator();
            instance.view = new CreateButton();
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
            assertTrue("instance is CreateButtonMediator", instance is CreateButtonMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_clicking_view_dispatches_NEW_MOSAIC_REQUESTED_event():void
        {
            var handler:Function = addAsync(check_clicking_view_dispatches_NEW_MOSAIC_REQUESTED_event, 50);
            instance.eventDispatcher.addEventListener(CreateMosaicEvent.NEW_MOSAIC_REQUESTED, handler);

            UnitHelpers.clickItem(instance.view);
        }

        protected function check_clicking_view_dispatches_NEW_MOSAIC_REQUESTED_event(e:CreateMosaicEvent):void
        {
            assertEquals('event is correct type', CreateMosaicEvent.NEW_MOSAIC_REQUESTED, e.type);
        }

    }
}