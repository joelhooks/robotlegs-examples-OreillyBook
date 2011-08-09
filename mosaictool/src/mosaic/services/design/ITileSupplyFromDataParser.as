package mosaic.services.design
{
    import mosaic.model.TileSupplyVO;

    public interface ITileSupplyFromDataParser
    {
        function createTileSuppliesFrom(data:Object):Vector.<TileSupplyVO>
    }
}