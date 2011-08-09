package mosaic.view.ui
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.Label;

    import flash.events.EventDispatcher;

    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.controller.events.DesignLoadEvent;
    import mosaic.controller.events.DesignSaveEvent;

    import org.robotlegs.mvcs.Mediator;

    public class DesignNameViewMediatorTest extends TestCase
    {
        protected var instance:DesignNameViewMediator;
        protected static const DESIGN_NAME:String = "Some design name";

        public function DesignNameViewMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new DesignNameViewMediator();
            instance.view = new DesignNameView();
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
            assertTrue("instance is DesignNameViewMediator", instance is DesignNameViewMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_designLoadEvent_LOAD_COMPLETED_updates_text():void
        {
            var evt:DesignLoadEvent = new DesignLoadEvent(DesignLoadEvent.LOAD_COMPLETED, DESIGN_NAME);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("DesignLoadEvent updates text ", DESIGN_NAME, label.text);
        }

        public function test_designSaveEvent_SAVE_COMPLETED_updates_text():void
        {
            var evt:DesignSaveEvent = new DesignSaveEvent(DesignSaveEvent.SAVE_COMPLETED, DESIGN_NAME);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("DesignSaveEvent updates text ", DESIGN_NAME, label.text);
        }

        public function test_designCreationEvent_DESIGN_CREATED_updates_text():void
        {
            var evt:DesignCreationEvent = new DesignCreationEvent(DesignCreationEvent.DESIGN_CREATED, 0, 0, DESIGN_NAME);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("DesignCreationEvent updates text ", DESIGN_NAME, label.text);
        }

        protected function get label():Label
        {
            return UnitHelpers.findInstanceOf(instance.view, Label) as Label;
        }
    }
}