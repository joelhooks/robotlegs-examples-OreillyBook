package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.WorkspaceColorEvent;
    import mosaic.model.IConfigModel;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Command;

    public class ChangeWorkspaceColorCommandTest extends TestCase
    {
        protected var instance:ChangeWorkspaceColorCommand;
        protected static const COLOR:uint = 0x334455;

        public function ChangeWorkspaceColorCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IConfigModel);
            mockolateMaker.addEventListener(Event.COMPLETE, prepareCompleteHandler);
        }

        private function prepareCompleteHandler(e:Event):void
        {
            IEventDispatcher(e.target).removeEventListener(Event.COMPLETE, prepareCompleteHandler);
            super.run();
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new ChangeWorkspaceColorCommand();
            instance.workspaceColorEvent = new WorkspaceColorEvent(WorkspaceColorEvent.COLOR_CHANGED, COLOR);
            instance.configModel = nice(IConfigModel);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is ChangeWorkspaceColorCommand", instance is ChangeWorkspaceColorCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_updates_workspace_color_on_spec_model():void
        {
            instance.execute();
            verify(instance.configModel).setter("workspaceColor").args(equalTo(COLOR));
        }
    }
}