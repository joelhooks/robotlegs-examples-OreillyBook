package mosaic.model
{

    public class TileSupplyVOSupport extends TileSupplyVO
    {

        public function TileSupplyVOSupport(id:uint)
        {
            var color:uint = 0x111111 * id;
            var count:Number = 10 * id;
            super(id, color, count);
        }
    }
}
