package mosaic.view.grid
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

    import mosaic.controller.events.DesignEvent;
    import mosaic.controller.events.GridReadyEvent;
    import mosaic.controller.events.GroutEvent;
    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.controller.events.TileSupplyEvent;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Mediator;

    public class GridViewMediatorTest extends TestCase
    {
        protected var instance:GridViewMediator;

        protected static const ROW:uint = 3;
        protected static const COLUMN:uint = 4;
        protected static const COLOR:uint = 0x556677;
        protected static const GRID_COLORS:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();


        public function GridViewMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(ITileFactory, GridView);
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
            instance = new GridViewMediator();
            instance.eventDispatcher = new EventDispatcher();
            instance.view = new GridView(nice(ITileFactory));
            instance.setViewComponent(instance.view);
            instance.onRegister();
        }

        override protected function tearDown():void
        {
            super.tearDown();
            instance = null;
        }

        public function testInstantiated():void
        {
            assertTrue("instance is GridViewMediator", instance is GridViewMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_TileColorChangeEvent_is_redispatched_from_view():void
        {
            var handler:Function = addAsync(check_TileColorChangeEvent_is_redispatched_from_view, 50);
            instance.eventDispatcher.addEventListener(TileColorChangeEvent.CHANGED, handler);

            instance.view.dispatchEvent(new TileColorChangeEvent(TileColorChangeEvent.CHANGED, ROW, COLUMN, COLOR))
        }

        protected function check_TileColorChangeEvent_is_redispatched_from_view(e:TileColorChangeEvent):void
        {
            assertEquals('event is correct type', TileColorChangeEvent.CHANGED, e.type);
        }

        public function test_TileSupplyEvent_SUPPLY_CHANGED_changes_selection_color():void
        {
            instance.view = nice(GridView, null, [nice(ITileFactory)]);

            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_SELECTED, 0, COLOR, 0);
            instance.eventDispatcher.dispatchEvent(evt);

            try
            {
                verify(instance.view).setter('selectionColor').args(equalTo(COLOR));
            }
            catch(verificationError:VerificationError)
            {
                getResult().addFailure(this, new AssertionFailedError(verificationError.message));
            }
        }

        public function test_grout_color_change_event_changes_grout_color():void
        {
            instance.view = nice(GridView, null, [nice(ITileFactory)]);

            var evt:GroutEvent = new GroutEvent(GroutEvent.COLOR_CHANGED, COLOR);
            instance.eventDispatcher.dispatchEvent(evt);

            try
            {
                verify(instance.view).setter('groutColor').args(equalTo(COLOR));
            }
            catch(verificationError:VerificationError)
            {
                getResult().addFailure(this, new AssertionFailedError(verificationError.message));
            }
        }

        public function test_DesignChanged_event_refreshes_design_on_grid():void
        {
            instance.view = nice(GridView, null, [nice(ITileFactory)]);

            var evt:DesignEvent = new DesignEvent(DesignEvent.DESIGN_COLORS_CHANGED, GRID_COLORS);

            instance.eventDispatcher.dispatchEvent(evt);

            try
            {
                verify(instance.view).method('applyColorsToWholeGrid').args(equalTo(GRID_COLORS));
            }
            catch(verificationError:VerificationError)
            {
                getResult().addFailure(this, new AssertionFailedError(verificationError.message));
            }
        }

        public function test_selected_supply_color_changed_changes_color():void
        {
            instance.view = nice(GridView, null, [nice(ITileFactory)]);

            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SELECTED_SUPPLY_COLOR_CHANGED, 0, COLOR, 0);
            instance.eventDispatcher.dispatchEvent(evt);

            try
            {
                verify(instance.view).setter('selectionColor').args(equalTo(COLOR));
            }
            catch(verificationError:VerificationError)
            {
                getResult().addFailure(this, new AssertionFailedError(verificationError.message));
            }
        }

        public function test_onRegister_dispatches_GridReadyEvent():void
        {
            var handler:Function = addAsync(check_onRegister_dispatches_GridReadyEvent, 50);
            instance.eventDispatcher.addEventListener(GridReadyEvent.READY, handler);

            instance.onRegister();
        }

        private function check_onRegister_dispatches_GridReadyEvent(e:GridReadyEvent):void
        {
            assertEquals('event is correct type', GridReadyEvent.READY, e.type);
        }
    }
}