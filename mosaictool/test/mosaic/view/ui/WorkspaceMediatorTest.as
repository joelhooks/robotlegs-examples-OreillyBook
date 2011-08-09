package mosaic.view.ui
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.WorkspaceColorEvent;

    import org.robotlegs.mvcs.Mediator;

    public class WorkspaceMediatorTest extends TestCase
    {
        protected var instance:WorkspaceMediator;
        protected static const NEW_COLOR:uint = 0x994488;

        public function WorkspaceMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new WorkspaceMediator();
            instance.view = new Workspace(10, 20);
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
            assertTrue("instance is WorkspaceMediator", instance is WorkspaceMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_WorkspaceColorEvent_CHANGED_changes_color_on_view():void
        {
            var evt:WorkspaceColorEvent = new WorkspaceColorEvent(WorkspaceColorEvent.COLOR_CHANGED, NEW_COLOR);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("has passed color to view", NEW_COLOR, UnitHelpers.getColorTransformOf(instance.view));
        }

        public function test_WorkspaceColorEvent_LOADED_changes_color_on_view():void
        {
            var evt:WorkspaceColorEvent = new WorkspaceColorEvent(WorkspaceColorEvent.COLOR_LOADED, NEW_COLOR);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("has passed color to view", NEW_COLOR, UnitHelpers.getColorTransformOf(instance.view));
        }

    }
}