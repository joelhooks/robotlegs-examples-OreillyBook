package mosaic.controller.commands
{
    import mosaic.controller.events.TileSuppliesCombinedEvent;
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.ITileSuppliesModel;

    import org.robotlegs.mvcs.Command;

    public class CombineTileSupplyCommand extends Command
    {
        [Inject]
        public var tileSuppliesCombinedEvent:TileSuppliesCombinedEvent;

        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel;

        [Inject]
        public var designModel:IMosaicDesignModel;

        override public function execute():void
        {
            var idWas:uint = tileSuppliesCombinedEvent.deleteID;
            var idNow:uint = tileSuppliesCombinedEvent.combineWithID;

            tileSuppliesModel.combineSupplies(idWas, idNow);
            designModel.switchTileColors(idWas, idNow);
        }
    }
}