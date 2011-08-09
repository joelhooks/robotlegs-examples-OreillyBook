package mosaic.controller.commands
{

    import mosaic.controller.events.GroutEvent;
    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.model.TileSupplyVO;

    public class RestoreGridStatusCommand extends RefreshDesignColorsCommand
    {
        override protected function dispatchDesign(design:Vector.<Vector.<uint>>):void
        {
            super.dispatchDesign(design);

            var groutEvent:GroutEvent = new GroutEvent(GroutEvent.COLOR_LOADED, specModel.groutColor);
            dispatch(groutEvent);

            if (tileSupplies.supplyList.length > 0)
            {
                var tileSupply:TileSupplyVO = tileSupplies.supplyList[0];

                var selectedTileEvent:TileSupplyEvent = new TileSupplyEvent(TileSupplyEvent.SELECTED_SUPPLY_COLOR_CHANGED, tileSupply.id, tileSupply.color, 0);
                dispatch(selectedTileEvent);
            }
        }
    }
}