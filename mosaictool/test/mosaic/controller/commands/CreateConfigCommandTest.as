package mosaic.controller.commands
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.controller.events.MosaicConfigServiceEvent;
    import mosaic.model.IConfigModel;
    import mosaic.model.values.DefaultDesignName;
    import mosaic.model.values.DefaultGridSize;
    import mosaic.model.values.DefaultWorkspaceColor;

    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.instanceOf;
    import org.robotlegs.mvcs.Command;

    public class CreateConfigCommandTest extends TestCase
    {
        protected var instance:CreateConfigCommand;
        protected var DEFAULT_WORKSPACE_COLOR:uint = 0x334455;
        protected var DEFAULT_DESIGN_NAME:String = "Some design";
        protected var ROWS:uint = 4;
        protected var COLUMNS:uint = 5;

        public function CreateConfigCommandTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(IConfigModel);
            mockolateMaker.addEventListener(Event.COMPLETE, prepareCompleteHandler);
        }

        protected function prepareCompleteHandler(e:Event):void
        {
            IEventDispatcher(e.target).removeEventListener(Event.COMPLETE, prepareCompleteHandler);
            super.run();
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new CreateConfigCommand();
            instance.configModel = nice(IConfigModel);
            instance.eventDispatcher = new EventDispatcher();
            instance.defaultWorkspaceColor = new DefaultWorkspaceColor(DEFAULT_WORKSPACE_COLOR);
            instance.firstDesignName = new DefaultDesignName(DEFAULT_DESIGN_NAME);
            instance.defaultGridSize = new DefaultGridSize(ROWS, COLUMNS);
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is CreateConfigCommand", instance is CreateConfigCommand);
        }

        public function testIsCommand():void
        {
            assertTrue("instance is robotlegs Command", instance is Command);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function testExecute_populates_config_with_a_design():void
        {
            instance.execute();
            verify(instance.configModel).setter("designNames").args(instanceOf(Vector.<String> as Class));
        }

        public function test_execute_populates_config_with_workspaceColor():void
        {
            instance.execute();
            verify(instance.configModel).setter("workspaceColor").args(equalTo(DEFAULT_WORKSPACE_COLOR));
        }

        public function test_dispatches_config_save_requested():void
        {
            var handler:Function = addAsync(check_dispatches_config_save_requested, 50);
            instance.eventDispatcher.addEventListener(MosaicConfigServiceEvent.CONFIG_CREATED, handler);

            instance.execute();
        }

        protected function check_dispatches_config_save_requested(e:MosaicConfigServiceEvent):void
        {
            assertEquals('event is correct type', MosaicConfigServiceEvent.CONFIG_CREATED, e.type);
        }

        public function test_dispatches_grid_creation_event_with_default_values():void
        {
            var handler:Function = addAsync(check_dispatches_grid_creation_event_with_default_values, 50);
            instance.eventDispatcher.addEventListener(DesignCreationEvent.DESIGN_CREATED, handler);

            instance.execute();
        }

        protected function check_dispatches_grid_creation_event_with_default_values(e:DesignCreationEvent):void
        {
            assertEquals('event has correct rows', ROWS, e.rows);
            assertEquals('event has correct columns', COLUMNS, e.columns);
            assertEquals('event has correct designName', DEFAULT_DESIGN_NAME, e.designName);
        }

    }
}