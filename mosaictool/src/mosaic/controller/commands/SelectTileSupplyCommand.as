package mosaic.controller.commands
{
    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.model.ITileSuppliesModel;

    import org.robotlegs.mvcs.Command;

    public class SelectTileSupplyCommand extends Command
    {
        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel;

        [Inject]
        public var tileSupplyEvent:TileSupplyEvent;

        override public function execute():void
        {
            tileSuppliesModel.selectedSupplyID = tileSupplyEvent.id;
        }
    }
}