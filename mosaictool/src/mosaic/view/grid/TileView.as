package mosaic.view.grid
{

    import flash.display.DisplayObject;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;

    public class TileView extends Sprite implements ITileView
    {

        protected var _fill:Shape;

        public function TileView(tileSize:Number, defaultColor:Number)
        {
            drawContents(tileSize, defaultColor);
        }

        public function set color(color_to_use:uint):void
        {
            var updatedColor:ColorTransform = new ColorTransform();
            updatedColor.color = color_to_use;
            _fill.transform.colorTransform = updatedColor;
        }

        public function get asDisplayObject():DisplayObject
        {
            return this;
        }


        protected function drawContents(tileSize:Number, defaultColor:uint):void
        {
            _fill = new Shape();
            _fill.graphics.beginFill(0x000000, 1);
            var drawingCoord:Number = tileSize / 2;
            _fill.graphics.drawRect(-drawingCoord, -drawingCoord, tileSize, tileSize);
            _fill.graphics.endFill();

            color = (defaultColor);

            addChild(_fill);
        }

    }
}