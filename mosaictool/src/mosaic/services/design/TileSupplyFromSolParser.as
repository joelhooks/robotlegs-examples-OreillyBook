package mosaic.services.design
{
    import mosaic.model.TileSupplyVO;
    import mosaic.model.utils.IAutoIncrementor;

    public class TileSupplyFromSolParser implements ITileSupplyFromDataParser
    {
        [Inject]
        public var tileAutoIncrementor:IAutoIncrementor;

        public function createTileSuppliesFrom(data:Object):Vector.<TileSupplyVO>
        {
            var tileSuppliesData:Vector.<Object> = Vector.<Object>(data.supplyList);
            var tileSupplies:Vector.<TileSupplyVO> = new Vector.<TileSupplyVO>();

            var rawData:Object;
            var maxID:uint = 0;

            var tileCountsByID:Array = createTileCountsFrom(data.gridDesign);

            var iLength:uint = tileSuppliesData.length;
            for (var i:int = 0; i < iLength; i++)
            {
                rawData = tileSuppliesData[i]

                var id:uint = rawData.id;
                var color:uint = rawData.color;
                var count:Number = (tileCountsByID[id] || 0);
                tileSupplies.push(new TileSupplyVO(id, color, count));

                maxID = Math.max(maxID, id);
            }

            tileAutoIncrementor.currentIndex = maxID;

            return tileSupplies;
        }

        protected function createTileCountsFrom(gridDesign:*):Array
        {
            var tileCounts:Array = [];
            var id:uint;

            var iLength:uint = gridDesign.length;
            var jLength:uint = gridDesign[0].length;

            for (var i:int = 0; i < iLength; i++)
            {
                for (var j:int = 0; j < jLength; j++)
                {
                    id = gridDesign[i][j];
                    tileCounts[id] = (tileCounts[id] || 0);
                    tileCounts[id] += 1;
                }
            }

            return tileCounts;
        }
    }
}