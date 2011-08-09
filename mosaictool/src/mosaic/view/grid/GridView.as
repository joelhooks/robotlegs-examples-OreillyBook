package mosaic.view.grid
{
    import flash.display.Sprite;

    import mosaic.controller.events.TileColorChangeEvent;

    import utils.ContrastingColor;

    public class GridView extends Sprite implements IGridView
    {
        protected var _selectionColor:uint;
        protected var _groutColor:uint;
        protected var _tileFactory:ITileFactory;
        protected var _groutLines:GroutLinesView;
        protected var _tilesView:GridTilesView;

        public function GridView(tileFactory:ITileFactory)
        {
            _tileFactory = tileFactory;
            _selectionColor = new ContrastingColor(tileFactory.defaultColor).color;
        }

        public function setGridSize(rows:uint, columns:uint):void
        {
            addTiles(rows, columns);
            addGrout(rows, columns);
        }

        public function set groutColor(color:uint):void
        {
            if (_groutLines && _groutColor != color)
            {
                _groutLines.color = color;
            }
            _groutColor = color;
        }

        public function applyColorsToWholeGrid(colorDataGrid:Vector.<Vector.<uint>>):void
        {
            var applyColor:Function = function(tile:ITileView, color:uint):void
            {
                tile.color = color;
            }
            new Griderator().apply(_tilesView.tiles, colorDataGrid, applyColor);
        }

        public function set selectionColor(color:uint):void
        {
            _selectionColor = color;
        }

        protected function addTiles(rows:uint, columns:uint):void
        {
            removeIfRequired(_tilesView);
            _tilesView = new GridTilesView(_tileFactory, rows, columns, changeTileColor);
            addChild(_tilesView);
            _tilesView.x = _tilesView.y = _tileFactory.tileSize / 2;
        }

        protected function changeTileColor(selectedTile:ITileView, row:uint, column:uint):void
        {
            selectedTile.color = _selectionColor;
            dispatchEvent(new TileColorChangeEvent(TileColorChangeEvent.CHANGED, row, column, _selectionColor));
        }

        protected function addGrout(rows:uint, columns:uint):void
        {
            removeIfRequired(_groutLines);
            _groutLines = new GroutLinesView(rows, columns, _tileFactory.tileSize);
            addChild(_groutLines);
        }

        protected function removeIfRequired(item:Sprite):void
        {
            if (item != null)
            {
                removeChild(item);
            }
        }
    }
}