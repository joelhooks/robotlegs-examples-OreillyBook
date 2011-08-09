package mosaic.view.grid
{
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.utils.Dictionary;

    public class GridTilesView extends Sprite
    {
        protected var _tileFactory:ITileFactory;
        protected var _tiles:Vector.<Vector.<ITileView>>;
        protected var _positionsByTiles:Dictionary;
        protected var _clickHandler:Function;

        public function GridTilesView(tileFactory:ITileFactory, rows:uint, columns:uint, clickHandler:Function)
        {
            _tileFactory = tileFactory;
            _positionsByTiles = new Dictionary();
            _clickHandler = clickHandler;
            addTiles(rows, columns);
        }

        public function get tiles():Vector.<Vector.<ITileView>>
        {
            return _tiles;
        }

        protected function addTiles(rows:uint, columns:uint):void
        {
            _tiles = Vector.<Vector.<ITileView>>(new Griderator().build(rows, columns, generateTile, Vector.<ITileView> as Class));
        }

        protected function generateTile(i:uint, j:uint):ITileView
        {
            var nextTile:ITileView = _tileFactory.createTile();
            _positionsByTiles[nextTile] = new Point(j, i);
            nextTile.addEventListener(MouseEvent.CLICK, handleTileClick, false, 0, true);
            addTileAtPosition(nextTile, i, j);
            return nextTile;
        }

        protected function addTileAtPosition(tile:ITileView, row:uint, column:uint):void
        {
            var tileSprite:DisplayObject = addChild(tile.asDisplayObject);
            tileSprite.x = (tileSprite.width * column);
            tileSprite.y = (tileSprite.width * row);
        }

        protected function handleTileClick(e:MouseEvent):void
        {
            var selectedTile:ITileView = (e.target as ITileView);
            var column:uint = _positionsByTiles[selectedTile].x;
            var row:uint = _positionsByTiles[selectedTile].y;

            _clickHandler(selectedTile, row, column);
        }
    }
}