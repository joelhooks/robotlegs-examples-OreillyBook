package mosaic.services.design
{
    import mosaic.model.TileSupplyVO;

    public class TileSupplyToSolParser implements ITileSupplyToDataParser
    {

        public function populateDataWithTileSupplies(data:Object, supplyList:Vector.<TileSupplyVO>):void
        {
            var tileSuppliesData:Vector.<Object> = new Vector.<Object>();
            var supplyObject:Object;
            var nextSupply:TileSupplyVO;

            var iLength:uint = supplyList.length;
            for (var i:int = 0; i < iLength; i++)
            {
                supplyObject = {};
                nextSupply = supplyList[i];

                supplyObject.id = nextSupply.id;
                supplyObject.color = nextSupply.color;

                tileSuppliesData[i] = supplyObject;
            }

            data.supplyList = tileSuppliesData;
        }

    }
}