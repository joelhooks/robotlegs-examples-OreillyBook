package mosaic.view.ui.dialogs
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.DesignSaveEvent;

    import org.robotlegs.mvcs.Mediator;

    public class SaveAsDialogMediatorTest extends TestCase
    {
        protected var instance:SaveAsDialogMediator;

        public function SaveAsDialogMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new SaveAsDialogMediator();
            instance.view = new SaveAsDialog(970, 550);
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
            assertTrue("instance is SaveAsDialogMediator", instance is SaveAsDialogMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_saveButton_click_on_view_dispatches_SAVE_AS_REQUESTED():void
        {
            var handler:Function = addAsync(check_saveButton_click_on_view_dispatches_SAVE_AS_REQUESTED, 50);
            instance.eventDispatcher.addEventListener(DesignSaveEvent.SAVE_AS_REQUESTED, handler);

            UnitHelpers.clickItem(instance.view.saveButton);
        }

        private function check_saveButton_click_on_view_dispatches_SAVE_AS_REQUESTED(e:DesignSaveEvent):void
        {
            assertEquals("picks up designName", instance.view.designName, e.designName);
        }
    }
}