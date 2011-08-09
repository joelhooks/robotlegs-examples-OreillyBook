package mosaic.view.ui.parts
{
    import flash.display.Sprite;
    import flash.geom.ColorTransform;

    public class DeleteIcon extends Sprite
    {
        protected var _icon:Sprite;

        public function DeleteIcon()
        {
            drawBackground();
            drawIcon();
        }

        public function set iconColor(color:uint):void
        {
            _icon.transform.colorTransform = createColorTransformOf(color);
        }

        protected function drawBackground():void
        {
            graphics.beginFill(0x999999, 1);
            graphics.lineStyle(2, 0xFFFFFF, 1);
            graphics.drawCircle(10, 10, 10);
        }

        protected function drawIcon():void
        {
            _icon = new Sprite();
            addChild(_icon);
            _icon.graphics.lineStyle(2, 0xFFFFFF, 1);
            _icon.graphics.moveTo(6, 6);
            _icon.graphics.lineTo(14, 14);
            _icon.graphics.moveTo(6, 14);
            _icon.graphics.lineTo(14, 6);
        }

        protected function createColorTransformOf(color:uint):ColorTransform
        {
            var colorTransform:ColorTransform = new ColorTransform();
            colorTransform.color = color;
            return colorTransform;
        }
    }
}