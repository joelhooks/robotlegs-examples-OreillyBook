package mosaic.view.grid
{
    import flash.display.Sprite;
    import flash.geom.ColorTransform;

    public class GroutLinesView extends Sprite
    {
        public function GroutLinesView(rows:uint, columns:uint, tileSize:Number)
        {
            drawLines(rows, columns, tileSize);
        }

        public function set color(groutColor:uint):void
        {
            var useColor:ColorTransform = new ColorTransform();
            useColor.color = groutColor;
            transform.colorTransform = useColor;
        }

        protected function drawLines(rows:uint, columns:uint, tileSize:Number):void
        {
            graphics.lineStyle(0, 0, 1);
            var verticalLineHeight:Number = (rows * tileSize);
            var horizontalLineWidth:Number = (columns * tileSize);

            drawVerticalLines(columns + 1, verticalLineHeight, tileSize);
            drawHorizontalLines(rows + 1, horizontalLineWidth, tileSize);
        }

        protected function drawVerticalLines(noOfLines:uint, lineHeight:Number, spacing:Number):void
        {
            graphics.moveTo(0, 0);
            var xPos:Number = 0;

            var iLength:uint = noOfLines;
            for (var i:int = 0; i < iLength; i++)
            {
                graphics.lineTo(xPos, lineHeight);
                xPos += spacing;
                graphics.moveTo(xPos, 0);
            }
        }

        protected function drawHorizontalLines(noOfLines:uint, lineWidth:Number, spacing:Number):void
        {
            graphics.moveTo(0, 0);
            var yPos:Number = 0;

            var iLength:uint = noOfLines;
            for (var i:int = 0; i < iLength; i++)
            {
                graphics.lineTo(lineWidth, yPos);
                yPos += spacing;
                graphics.moveTo(0, yPos);
            }
        }
    }
}