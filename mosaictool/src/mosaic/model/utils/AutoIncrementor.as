package mosaic.model.utils
{
    public class AutoIncrementor implements IAutoIncrementor
    {
        protected var _index:uint;

        public function set currentIndex(value:uint):void
        {
            _index = value;
        }

        public function get nextIndex():uint
        {
            return ++_index;
        }

        public function indexUsed(value:uint):void
        {
            _index = Math.max(_index, value);
        }

        public function reset():void
        {
            _index = 0;
        }
    }
}