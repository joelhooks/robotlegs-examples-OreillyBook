package mosaic.view.grid
{
    import flash.display.DisplayObject;

    public class GridLayout extends Object
    {
        protected var _grid:DisplayObject;
        protected var _leftOffset:Number;
        protected var _tileSize:Number;
        protected var _workingWidth:Number;
        protected var _workingHeight:Number;

        public function GridLayout(grid:DisplayObject, totalWidth:Number, totalHeight:Number, leftOffset:Number, tileSize:Number)
        {
            _grid = grid;
            _workingWidth = totalWidth - 1 - leftOffset;
            _workingHeight = totalHeight - 1;
            _leftOffset = leftOffset;
            _tileSize = tileSize;
        }

        public function resizeGridToFit(rows:uint, columns:uint):GridLayout
        {
            var columnFit:Number = _workingWidth / columns;
            var rowFit:Number = _workingHeight / rows;

            var requiredTileSize:uint;
            var requiredScale:Number;

            if (columnFit <= rowFit)
            {
                requiredTileSize = Math.floor(_workingWidth / columns);
                requiredScale = requiredTileSize / _tileSize;
            }
            else
            {
                requiredTileSize = Math.floor(_workingHeight / rows);
                requiredScale = requiredTileSize / _tileSize;
            }

            _grid.scaleX = _grid.scaleY = requiredScale;

            return this;
        }

        public function centerGrid():GridLayout
        {
            var spareWidth:Number = _workingWidth - _grid.width;
            var spareHeight:Number = _workingHeight - _grid.height;

            var xBorder:Number = Math.floor(spareWidth / 2);
            var yBorder:Number = Math.floor(spareHeight / 2);

            _grid.x = _leftOffset + xBorder;
            _grid.y = yBorder;

            return this;
        }
    }
}