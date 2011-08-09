package mosaic.view.ui.dialogs
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.DesignCreationEvent;

    import org.robotlegs.mvcs.Mediator;

    public class CreateMosaicDialogMediatorTest extends TestCase
    {
        protected var instance:CreateMosaicDialogMediator;

        public function CreateMosaicDialogMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new CreateMosaicDialogMediator();
            instance.view = new CreateMosaicDialog(800, 400);
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
            assertTrue("instance is CreateMosaicDialogMediator", instance is CreateMosaicDialogMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_createButton_click_on_view_dispatches_GridCreatedEvent():void
        {
            var handler:Function = addAsync(check_createButton_click_on_view_dispatches_GridCreatedEvent, 50);
            instance.eventDispatcher.addEventListener(DesignCreationEvent.DESIGN_CREATED, handler);

            UnitHelpers.clickItem(instance.view.createButton);
        }

        private function check_createButton_click_on_view_dispatches_GridCreatedEvent(e:DesignCreationEvent):void
        {
            assertEquals("picks up rows", instance.view.rows, e.rows);
            assertEquals("picks up columns", instance.view.columns, e.columns);
            assertEquals("picks up designName", instance.view.designName, e.designName);
        }
    }
}