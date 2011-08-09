package mosaic.services.design
{
    import mosaic.model.TileSupplyVO;

    public interface ITileSupplyToDataParser
    {

        function populateDataWithTileSupplies(data:Object, supplyList:Vector.<TileSupplyVO>):void;

    }
}