package mosaic.services.design
{
    import mosaic.model.IMosaicDesignModel;
    import mosaic.model.IMosaicSpecModel;
    import mosaic.model.ITileSuppliesModel;

    public class DesignFromSolParser implements IDesignFromDataParser
    {
        [Inject]
        public var designModel:IMosaicDesignModel;

        [Inject]
        public var designSpec:IMosaicSpecModel;

        [Inject]
        public var tileSuppliesModel:ITileSuppliesModel;

        [Inject]
        public var tileSupplyParser:ITileSupplyFromDataParser;

        public function populateDesignFromData(data:Object):Boolean
        {
            if (! checkDataForMissingItems(data))
            {
                return false;
            }
            populateSpec(data);
            populateTileSupplies(data);
            populateModel(data);

            return true;
        }

        protected function populateTileSupplies(data:Object):void
        {
            tileSuppliesModel.supplyList = tileSupplyParser.createTileSuppliesFrom(data);
        }

        protected function populateSpec(data:Object):void
        {
            designSpec.rows = data.rows;
            designSpec.columns = data.columns;
            designSpec.groutColor = data.groutColor;
            designSpec.defaultTileColor = data.defaultTileColor;
        }

        protected function populateModel(data:Object):void
        {
            designModel.loadDesign(Vector.<Vector.<uint>>(data.gridDesign));
        }

        protected function checkDataForMissingItems(data:Object):Boolean
        {
            var expectedEntries:Array = ['rows','columns','groutColor','defaultTileColor','gridDesign','supplyList'];
            var iLength:uint = expectedEntries.length;
            for (var i:int = 0; i < iLength; i++)
            {
                if (!data.hasOwnProperty(expectedEntries[i]))
                {
                    return false;
                }
            }
            return true;
        }
    }
}