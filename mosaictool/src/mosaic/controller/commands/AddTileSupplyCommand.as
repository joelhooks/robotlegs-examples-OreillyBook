package mosaic.controller.commands
{
    import mosaic.controller.events.TileSupplyEvent;
    import mosaic.model.ITileSuppliesModel;
    import mosaic.model.utils.IAutoIncrementor;

    import org.robotlegs.mvcs.Command;

    public class AddTileSupplyCommand extends Command
    {
        [Inject]
        public var tileSupplyEvent:TileSupplyEvent;

        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel;

        [Inject]
        public var tileSupplyIndexAutoIncrementor:IAutoIncrementor;

        override public function execute():void
        {
            var id:uint = tileSupplyIndexAutoIncrementor.nextIndex;
            var color:uint = tileSupplyEvent.color;

            tileSuppliesModel.addSupply(id, color);
        }
    }
}