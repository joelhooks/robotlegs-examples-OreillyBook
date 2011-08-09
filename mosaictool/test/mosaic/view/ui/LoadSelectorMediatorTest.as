package mosaic.view.ui
{

    import asunit.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;

    import mockolate.nice;
    import mockolate.prepare;
    import mockolate.verify;

    import mosaic.controller.events.DesignListEvent;
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.view.ui.events.LoadSelectorEvent;

    import org.hamcrest.object.equalTo;
    import org.robotlegs.mvcs.Mediator;

    public class LoadSelectorMediatorTest extends TestCase
    {
        protected var instance:LoadSelectorMediator;

        protected static const DESIGN_NAME:String = "design name";
        protected static const DESIGN_LIST:Vector.<String> = new Vector.<String>();


        public function LoadSelectorMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override public function run():void
        {
            var mockolateMaker:IEventDispatcher = prepare(LoadSelector);
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
            instance = new LoadSelectorMediator();
            instance.view = new LoadSelector();
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
            assertTrue("instance is LoadSelectorMediator", instance is LoadSelectorMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_loadSelectorEvent_from_view_triggers_load_request_with_correct_name():void
        {
            var handler:Function = addAsync(check_loadSelectorEvent_from_view_triggers_load_request_with_correct_name, 50);
            instance.eventDispatcher.addEventListener(DesignLoadEvent.LOAD_REQUESTED, handler);

            instance.view.dispatchEvent(new LoadSelectorEvent(LoadSelectorEvent.LOAD_CLICKED, DESIGN_NAME));
        }

        private function check_loadSelectorEvent_from_view_triggers_load_request_with_correct_name(e:DesignLoadEvent):void
        {
            assertEquals('event has correct design name', DESIGN_NAME, e.designName);
        }

        public function test_passes_design_list_to_view():void
        {
            instance.view = nice(LoadSelector);

            var designListEvent:DesignListEvent = new DesignListEvent(DesignListEvent.CHANGED, DESIGN_LIST);
            instance.eventDispatcher.dispatchEvent(designListEvent);

            verify(instance.view).setter("designList").args(equalTo(DESIGN_LIST));
        }
    }
}