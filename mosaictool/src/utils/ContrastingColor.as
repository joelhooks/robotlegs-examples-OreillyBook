package utils
{
    public class ContrastingColor
    {
        protected var _color:uint;

        public function ContrastingColor(color:uint)
        {
            _color = color < 0x666666 ? 0xFFFFFF : 0x000000;
        }

        public function get color():uint
        {
            return _color;
        }
    }
}

