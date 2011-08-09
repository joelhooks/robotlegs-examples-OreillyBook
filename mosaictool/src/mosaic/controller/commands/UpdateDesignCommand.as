package mosaic.controller.commands
{

    import mosaic.controller.events.TileColorChangeEvent;
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.ITileSuppliesModel;

    import org.robotlegs.mvcs.Command;

    public class UpdateDesignCommand extends Command
    {
        [Inject]
        public var designModel:IMosaicDesignModel;

        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel;

        [Inject]
        public var tileColorChangeEvent:TileColorChangeEvent;


        override public function execute():void
        {
            var row:uint = tileColorChangeEvent.row;
            var column:uint = tileColorChangeEvent.column;

            var idNow:uint = tileSuppliesModel.selectedSupplyID;

            var idWas:uint = designModel.changeTileColorAt(row, column, idNow);

            if (idNow != idWas)
            {
                tileSuppliesModel.switchTiles(idWas, idNow);
            }
        }
    }
}