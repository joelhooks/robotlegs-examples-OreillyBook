package mosaic.view.grid
{
    import mosaic.controller.events.DesignEvent;
    import mosaic.controller.events.GridReadyEvent;
    import mosaic.controller.events.GroutEvent;
    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.controller.events.TileSupplyEvent;

    import org.robotlegs.mvcs.Mediator;

    public class GridViewMediator extends Mediator
    {
        [Inject]
        public var view:GridView;

        override public function onRegister():void
        {
            addViewListener(TileColorChangeEvent.CHANGED, dispatch, TileColorChangeEvent);
            addContextListener(TileSupplyEvent.SUPPLY_SELECTED, changeSelectionColor, TileSupplyEvent);
            addContextListener(TileSupplyEvent.SELECTED_SUPPLY_COLOR_CHANGED, changeSelectionColor, TileSupplyEvent);
            addContextListener(GroutEvent.COLOR_CHANGED, changeGroutColor, GroutEvent);
            addContextListener(GroutEvent.COLOR_LOADED, changeGroutColor, GroutEvent);
            addContextListener(DesignEvent.DESIGN_COLORS_CHANGED, redrawGrid, DesignEvent);
            dispatch(new GridReadyEvent(GridReadyEvent.READY));
        }

        protected function changeSelectionColor(e:TileSupplyEvent):void
        {
            view.selectionColor = e.color;
        }

        protected function changeGroutColor(e:GroutEvent):void
        {
            view.groutColor = e.color;
        }

        protected function redrawGrid(e:DesignEvent):void
        {
            view.applyColorsToWholeGrid(e.colors);
        }
    }
}