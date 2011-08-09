package mosaic.view.grid
{

    import flash.display.Shape;

    public class QuarterTileView extends TileView
    {

        //--------------------------------------------------------------------------
        //
        //  Initialization
        //
        //--------------------------------------------------------------------------
        /**
         * Event handling takes place via the mediator: QuarterTileViewMediator
         *
         */

        public function QuarterTileView(tileSize:Number, defaultColor:Number)
        {
            super(tileSize, defaultColor);
        }

        override protected function drawContents(tileSize:Number, defaultColor:uint):void
        {
            // draw triangular quarter of square - top edge to center of square of tileSize x tileSize
            _fill = new Shape();
            _fill.graphics.beginFill(0x000000, 1);
            var drawingCoord:Number = tileSize / 2;

            _fill.graphics.moveTo(-drawingCoord, -drawingCoord);
            _fill.graphics.lineTo(drawingCoord, -drawingCoord);
            _fill.graphics.lineTo(0, 0);
            _fill.graphics.lineTo(-drawingCoord, -drawingCoord);

            _fill.graphics.endFill();

            color = (defaultColor);

            addChild(_fill);
        }

    }
}