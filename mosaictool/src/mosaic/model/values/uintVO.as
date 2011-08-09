package mosaic.model.values
{
    public class uintVO
    {
        protected var _value:uint;

        public function uintVO(value:uint)
        {
            _value = value;
        }

        public function get value():uint
        {
            return _value;
        }
    }
}

