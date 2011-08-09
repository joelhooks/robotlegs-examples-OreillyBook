package mosaic.model
{
    import org.robotlegs.mvcs.Actor;

    public class MosaicSpecModel extends Actor implements IMosaicSpecModel
    {
        protected var _rows:uint;
        protected var _columns:uint;
        protected var _defaultTileColor:uint;
        protected var _groutColor:uint;

        public function get rows():uint
        {
            return _rows;
        }

        public function set rows(value:uint):void
        {
            _rows = value;
        }

        public function get columns():uint
        {
            return _columns;
        }

        public function set columns(value:uint):void
        {
            _columns = value;
        }

        public function get defaultTileColor():uint
        {
            return _defaultTileColor;
        }

        public function set defaultTileColor(value:uint):void
        {
            _defaultTileColor = value;
        }

        public function get groutColor():uint
        {
            return _groutColor;
        }

        public function set groutColor(value:uint):void
        {
            _groutColor = value;
        }
    }
}