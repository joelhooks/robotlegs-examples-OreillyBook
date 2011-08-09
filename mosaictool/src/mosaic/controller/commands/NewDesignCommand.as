package mosaic.controller.commands
{
    import mosaic.controller.events.DesignCreationEvent;
    import mosaic.model.EmptyDesignGrid;
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.ITileSuppliesModel;
    import mosaic.model.TileSupplyVO;
    import mosaic.model.utils.IAutoIncrementor;
    import mosaic.model.values.DefaultTileColor;

    import org.robotlegs.mvcs.Command;

    import utils.ContrastingColor;

    public class NewDesignCommand extends Command
    {
        [Inject]
        public var designCreationEvent:DesignCreationEvent;

        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel;

        [Inject]
        public var designModel:IMosaicDesignModel;

        [Inject]
        public var specModel:IMosaicSpecModel;

        [Inject]
        public var defaultTileColor:DefaultTileColor;

        [Inject]
        public var autoIncrementor:IAutoIncrementor;

        override public function execute():void
        {
            autoIncrementor.reset();

            var rows:uint = designCreationEvent.rows;
            var columns:uint = designCreationEvent.columns;

            designModel.loadDesign(new EmptyDesignGrid(rows, columns).grid);
            specModel.rows = rows;
            specModel.columns = columns;
            specModel.defaultTileColor = defaultTileColor.value;

            tileSuppliesModel.supplyList = createTileSupplies();
        }

        protected function createTileSupplies():Vector.<TileSupplyVO>
        {
            var startTileColor:uint = new ContrastingColor(defaultTileColor.value).color;
            var firstSupply:TileSupplyVO = new TileSupplyVO(autoIncrementor.nextIndex, startTileColor, 0);
            return Vector.<TileSupplyVO>([firstSupply]);
        }
    }
}