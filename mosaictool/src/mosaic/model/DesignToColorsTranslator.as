package mosaic.model
{

    import flash.utils.Dictionary;

    import mosaic.model.utils.ID;
    import mosaic.model.utils.IDIndexer;

    public class DesignToColorsTranslator implements IDesignToColorsTranslator
    {
        protected var _suppliesByID:Dictionary;

        public function processDesign(designGrid:Vector.<Vector.<uint>>, tileSupplies:Vector.<TileSupplyVO>, defaultColor:uint):Vector.<Vector.<uint>>
        {
            indexSupplies(tileSupplies, defaultColor);

            var colorsGrid:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>();

            var iLength:uint = designGrid.length;
            var jLength:uint = designGrid[0].length;

            for (var i:int = 0; i < iLength; i++)
            {
                colorsGrid[i] = new Vector.<uint>();

                for (var j:int = 0; j < jLength; j++)
                {
                    colorsGrid[i][j] = findColorForID(designGrid[i][j]);
                }
            }
            return colorsGrid;
        }

        protected function indexSupplies(tileSupplies:Vector.<TileSupplyVO>, defaultColor:uint):void
        {
            var indexer:IDIndexer = new IDIndexer();
            _suppliesByID = indexer.createIndex(Vector.<ID>(tileSupplies));
            _suppliesByID[0] = new TileSupplyVO(0, defaultColor, 0);
        }

        protected function findColorForID(id:uint):uint
        {
            return _suppliesByID[id].color;
        }
    }
}