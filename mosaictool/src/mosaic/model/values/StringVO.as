package mosaic.model.values
{
    public class StringVO
    {
        protected var _value:String;

        public function StringVO(text:String)
        {
            _value = text;
        }

        public function toString():String
        {
            return _value;
        }
    }
}

