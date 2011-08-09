package mosaic.services.design
{
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.ITileSuppliesModel;

    import org.robotlegs.mvcs.Actor;

    public class DesignToSolParser extends Actor implements IDesignToDataParser
    {
        [Inject]
        public var designModel:IMosaicDesignModel;

        [Inject]
        public var designSpec:IMosaicSpecModel;

        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel;

        [Inject]
        public var tileSupplyParser:ITileSupplyToDataParser;

        public function populateDataFromDesign(data:Object):void
        {
            populateDataFromSpec(data);
            populateDataFromGrid(data);
            populateDataFromTileSupplies(data);
        }

        protected function populateDataFromSpec(data:Object):void
        {
            data.rows = designSpec.rows;
            data.columns = designSpec.columns;
            data.groutColor = designSpec.groutColor;
            data.defaultTileColor = designSpec.defaultTileColor;
        }

        protected function populateDataFromGrid(data:Object):void
        {
            data.gridDesign = designModel.getDesign();
        }

        protected function populateDataFromTileSupplies(data:Object):void
        {
            tileSupplyParser.populateDataWithTileSupplies(data, tileSuppliesModel.supplyList);
        }
    }
}