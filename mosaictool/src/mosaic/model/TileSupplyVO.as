package mosaic.model
{
    import mosaic.model.utils.ID;

    public class TileSupplyVO implements ID
    {
        protected var _id:uint;
        protected var _color:uint;
        protected var _count:Number;

        public function TileSupplyVO(id:uint, color:uint, count:Number)
        {
            _id = id;
            _color = color;
            _count = count;
        }

        public function get id():uint
        {
            return _id;
        }

        public function get color():uint
        {
            return _color;
        }

        public function updateColor(value:uint):Boolean
        {
            if (value != _color)
            {
                _color = value;
                return true;
            }

            return false;
        }

        public function get count():Number
        {
            return _count;
        }

        public function set count(value:Number):void
        {
            _count = value;
        }
    }
}