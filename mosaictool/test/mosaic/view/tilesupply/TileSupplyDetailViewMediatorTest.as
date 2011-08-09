package mosaic.view.tilesupply
{

    import asunit.framework.TestCase;

    import com.newloop.util.UnitHelpers;

    import fl.controls.ColorPicker;
    import fl.controls.Label;

    import flash.events.Event;
    import flash.events.EventDispatcher;

    import mosaic.controller.events.TileSupplyEvent;

    import org.robotlegs.mvcs.Mediator;

    public class TileSupplyDetailViewMediatorTest extends TestCase
    {
        protected var instance:TileSupplyDetailViewMediator;

        protected static const ID:uint = 3;
        protected static const COLOR:uint = 0x330000;
        protected static const COUNT:Number = 150.5;
        protected static const UPDATED_COUNT:Number = 140;
        protected static const CHANGED_COLOR:uint = 0x339966;

        public function TileSupplyDetailViewMediatorTest(methodName:String = null)
        {
            super(methodName)
        }

        override protected function setUp():void
        {
            super.setUp();
            instance = new TileSupplyDetailViewMediator();
            instance.view = new TileSupplyDetailView(ID, COLOR, COUNT);
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
            assertTrue("instance is TileSupplyDetailViewMediator", instance is TileSupplyDetailViewMediator);
        }

        public function testIsMediator():void
        {
            assertTrue("instance is robotlegs Mediator", instance is Mediator);
        }

        public function testFailure():void
        {
            assertTrue("Failing test", true);
        }

        public function test_clicking_deleteButton_dispatches_SUPPLY_DELETION_REQUESTED_after_initialisation():void
        {
            addAsync(null, 50, clicking_deleteButton_dispatches_SUPPLY_DELETION_REQUESTED);
        }

        protected function clicking_deleteButton_dispatches_SUPPLY_DELETION_REQUESTED(e:Event):void
        {
            var handler:Function = addAsync(check_clicking_deleteButton_dispatches_SUPPLY_DELETION_REQUESTED, 50);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.SUPPLY_DELETION_REQUESTED, handler);

            UnitHelpers.clickItem(instance.view.deleteButton);
        }

        protected function check_clicking_deleteButton_dispatches_SUPPLY_DELETION_REQUESTED(e:TileSupplyEvent):void
        {
            assertEquals("event carries correct id", ID, e.id);
            assertEquals("event carries correct color", COLOR, e.color);
        }

        public function test_dispatches_TileSupplyEvent_COLOR_CHANGED_when_colorPicker_fires_change():void
        {
            addAsync(null, 50, dispatchColorChangeAfterRendering);
        }

        protected function dispatchColorChangeAfterRendering(e:Event):void
        {
            var handler:Function = addAsync(check_dispatches_TileSupplyEvent_COLOR_CHANGED_when_colorPicker_fires_change, 150);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.COLOR_CHANGED, handler);

            colorPicker.selectedColor = CHANGED_COLOR;
            colorPicker.dispatchEvent(new Event(Event.CHANGE));
        }

        protected function check_dispatches_TileSupplyEvent_COLOR_CHANGED_when_colorPicker_fires_change(e:TileSupplyEvent):void
        {
            assertEquals("correct color is sent", CHANGED_COLOR, e.color);
        }

        public function test_dispatches_TileSupplyEvent_SUPPLY_SELECTED_when_radio_button_selected():void
        {
            addAsync(null, 50, dispatchRadioSelectAfterRendering);
        }

        protected function dispatchRadioSelectAfterRendering(e:Event):void
        {
            var handler:Function = addAsync(check_dispatches_TileSupplyEvent_SUPPLY_SELECTED_when_radio_button_selected, 150);
            instance.eventDispatcher.addEventListener(TileSupplyEvent.SUPPLY_SELECTED, handler);

            colorPicker.selectedColor = CHANGED_COLOR;
            UnitHelpers.clickItem(instance.view.radioButton);
        }

        protected function check_dispatches_TileSupplyEvent_SUPPLY_SELECTED_when_radio_button_selected(e:TileSupplyEvent):void
        {
            assertEquals("correct color is sent", CHANGED_COLOR, e.color);
            assertEquals("correct id is sent", ID, e.id);
        }

        public function test_QUANTITY_CHANGED_updates_view_if_id_matches():void
        {
            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.QUANTITY_CHANGED, ID, COLOR, UPDATED_COUNT);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("has updated count on view", UPDATED_COUNT, UnitHelpers.getTextInInstanceOf(instance.view, Label, 2));
        }

        public function test_QUANTITY_CHANGED_doesnt_update_view_if_id_doesnt_match():void
        {
            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.QUANTITY_CHANGED, ID + 1, COLOR, UPDATED_COUNT);
            instance.eventDispatcher.dispatchEvent(evt);

            assertEquals("has not updated count on view", COUNT, UnitHelpers.getTextInInstanceOf(instance.view, Label, 2));
        }

        protected function get colorPicker():ColorPicker
        {
            return UnitHelpers.findInstanceOf(instance.view, ColorPicker);
        }

    }
}