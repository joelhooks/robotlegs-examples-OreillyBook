package mosaic.model.values
{
    public class DefaultGridSize
    {
        protected var _rows:uint;
        protected var _columns:uint;

        public function DefaultGridSize(rows:uint, columns:uint)
        {
            _rows = rows;
            _columns = columns;
        }

        public function get rows():uint
        {
            return _rows;
        }

        public function get columns():uint
        {
            return _columns;
        }
    }
}

