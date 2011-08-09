package mosaic.view.grid
{

    public class TileFactory implements ITileFactory
    {

        protected var _defaultColor:uint;
        protected var _tileSize:uint;

        public function TileFactory(tileSize:Number, defaultColor:uint)
        {
            _tileSize = tileSize;
            _defaultColor = defaultColor;
        }

        public function get tileSize():Number
        {
            return _tileSize;
        }

        public function set tileSize(size:Number):void
        {
            _tileSize = size;
        }

        public function get defaultColor():uint
        {
            return _defaultColor;
        }

        public function set defaultColor(color:uint):void
        {
            _defaultColor = color;
        }

        public function createTile():ITileView
        {
            return new TileView(_tileSize, _defaultColor);
        }

        public function createQuarterTile():ITileView
        {
            return new QuarterTileView(_tileSize, _defaultColor);
        }
    }
}
