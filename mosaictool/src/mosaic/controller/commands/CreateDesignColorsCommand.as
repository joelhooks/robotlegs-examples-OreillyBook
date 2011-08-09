package mosaic.controller.commands
{
    import mosaic.controller.events.DesignEvent;
    import mosaic.controller.events.GroutEvent;
    import mosaic.controller.events.TileColorChangeEvent;

    public class CreateDesignColorsCommand extends RefreshDesignColorsCommand
    {

        override protected function dispatchDesign(design:Vector.<Vector.<uint>>):void
        {
            var evt:DesignEvent = new DesignEvent(DesignEvent.DESIGN_COLORS_LOADED, design);
            dispatch(evt);

            var groutEvent:GroutEvent = new GroutEvent(GroutEvent.COLOR_LOADED, specModel.groutColor);
            dispatch(groutEvent);

            var defaultTileColorEvent:TileColorChangeEvent = new TileColorChangeEvent(TileColorChangeEvent.DEFAULT_LOADED,
                    0, 0, specModel.defaultTileColor);
            dispatch(defaultTileColorEvent);
        }
    }
}