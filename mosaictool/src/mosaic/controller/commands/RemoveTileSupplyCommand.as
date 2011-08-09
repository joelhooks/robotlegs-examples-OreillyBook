package mosaic.controller.commands
{
    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.model.ITileSuppliesModel;

    import org.robotlegs.mvcs.Command;

    public class RemoveTileSupplyCommand extends Command
    {
        [Inject]
        public var tileSupplyEvent:TileSupplyEvent;

        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel

        override public function execute():void
        {
            tileSuppliesModel.removeSupply(tileSupplyEvent.id);
        }
    }
}