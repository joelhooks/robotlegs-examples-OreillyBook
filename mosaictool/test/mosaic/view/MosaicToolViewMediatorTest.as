package mosaic.view
{

    import asunit.errors.AssertionFailedError;
    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mockolate.errors.VerificationError;
    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.controller.events.DesignEvent;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Mediator;

    public class MosaicToolViewMediatorTest extends TestCase
    {
        protected var instance:MosaicToolViewMediator;
        protected static const ROWS:uint = 20;
        protected static const COLUMNS:uint = 30;
        protected static const COLORS_GRID:Vector.<Vector.<uint>> = Vector.<Vector.<uint>>([Vector.<uint>([9])]);

        public function MosaicToolViewMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(MosaicToolView);
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
            instance = new MosaicToolViewMediator();
            instance.view = nice(MosaicToolView, null, [null, 150]);
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
            assertTrue("instance is MosaicToolViewMediator", instance is MosaicToolViewMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_DesignCreationEvent_DESIGN_CREATED_triggers_show_grid_with_correct_arguments():void
        {
            var gridCreatedEvent:DesignCreationEvent = new DesignCreationEvent(DesignCreationEvent.DESIGN_CREATED, ROWS, COLUMNS, '');

            instance.eventDispatcher.dispatchEvent(gridCreatedEvent);
            try
            {
                verify(instance.view).method('showGrid').args(equalTo(ROWS), equalTo(COLUMNS));
            }
            catch(verificationError:VerificationError)
            {
                getResult().addFailure(this, new AssertionFailedError(verificationError.message));
            }
        }

        public function test_DesignEvent_DESIGN_MODEL_CHANGED_triggers_showGridWithColors_with_correct_args():void
        {
            var designEvent:DesignEvent = new DesignEvent(DesignEvent.DESIGN_COLORS_LOADED, COLORS_GRID);
            instance.eventDispatcher.dispatchEvent(designEvent);

            verify(instance.view).method("showGrid").args(equalTo(1), equalTo(1));
        }
    }
}