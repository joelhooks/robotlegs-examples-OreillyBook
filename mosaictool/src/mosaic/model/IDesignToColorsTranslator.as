package mosaic.model
{
    public interface IDesignToColorsTranslator
    {
        function processDesign(designGrid:Vector.<Vector.<uint>>, tileSupplies:Vector.<TileSupplyVO>, defaultColor:uint):Vector.<Vector.<uint>>;
    }
}
