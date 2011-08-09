package mosaic.view.tilesupply
{
    import flash.events.MouseEvent;

    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.view.ui.colorselectors.events.ColorChangeEvent;

    import org.robotlegs.mvcs.Mediator;

    public class TileSupplyDetailViewMediator extends Mediator
    {
        [Inject]
        public var view:TileSupplyDetailView;

        override public function onRegister():void
        {
            eventMap.mapListener(view.deleteButton, MouseEvent.CLICK, dispatchDeletionRequest, MouseEvent);
            eventMap.mapListener(view.radioButton, MouseEvent.CLICK, dispatchSupplySelected, MouseEvent);
            addViewListener(ColorChangeEvent.CHANGED, dispatchColorChange, ColorChangeEvent);
            addContextListener(TileSupplyEvent.QUANTITY_CHANGED, updateCount, TileSupplyEvent);
        }

        protected function dispatchDeletionRequest(e:MouseEvent):void
        {
            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_DELETION_REQUESTED, view.id, view.selectedColor, 0);
            dispatch(evt);
        }

        protected function dispatchColorChange(e:ColorChangeEvent):void
        {
            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.COLOR_CHANGED, view.id, e.color, 0);
            dispatch(evt);
        }

        protected function dispatchSupplySelected(e:MouseEvent):void
        {
            var evt:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SUPPLY_SELECTED, view.id, view.selectedColor, 0);
            dispatch(evt);
        }

        protected function updateCount(e:TileSupplyEvent):void
        {
            if (e.id == view.id)
            {
                view.count = e.count;
            }
        }

    }
}